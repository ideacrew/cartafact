require 'rails_helper'

RSpec.describe Api::V1::DocumentsController, type: :controller do
  let(:tempfile) do
    tf = Tempfile.new('test.pdf')
    tf.write("DATA GOES HERE")
    tf.rewind
    tf
  end
  let(:key) { Rails.application.credentials[:enroll_dc] }
  let(:authorization_information) do
    instance_double(
      RequestingIdentity,
      authorized_subjects: []
    )
  end

  let(:authorization_successful) do
    double(success?: true, value!: authorization_information)
  end

  let(:authorization_failed) do
    double(success?: false)
  end

  describe "#create" do
    context "succesful with valid params" do
      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        post :create, params: {
          document: JSON.dump(
            {
              subjects: [{ subject_id: 'abc', subject_type: 'consumer' }],
              document_type: 'vlp_doc',
              format: "application/pdf",
              creator: 'dc',
              publisher: 'dc',
              type: 'text',
              source: 'enroll_system',
              language: 'en',
              date_submitted: Date.today
            }
          ),
          content: Rack::Test::UploadedFile.new(tempfile, "application/pdf")
        }
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return document reference id" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).not_to eq nil
      end

      it "should create the file upload" do
        parsed_response = JSON.parse(response.body)

        document_id = parsed_response['id']
        document = Documents::DocumentModel.find(BSON::ObjectId.from_string(document_id))
        expect(document.file.read).to eq "DATA GOES HERE"
      end
    end

    context "with invalid params" do
      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        post :create, params: {
          document: JSON.dump(document_type: ""), content: Rack::Test::UploadedFile.new(tempfile, "application/pdf")
        }
      end

      it "is invalid" do
        expect(response).to have_http_status("422")
      end
    end

    context "when unauthorized" do
      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_failed)
        post :create, params: { document: { subjects: [{ id: 'abc', type: 'consumer' }], document_type: 'vlp_doc' } }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "#update" do
    let(:document) { FactoryBot.create(:documents_document_model) }
    context "succesful with valid params" do
      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        post :update, params: {
          document: JSON.dump(
            {
              subjects: [{ subject_id: 'abc', subject_type: 'consumer' }],
              document_type: 'vlp_doc',
              format: "application/pdf",
              creator: 'dc',
              publisher: 'dc',
              type: 'text',
              source: 'enroll_system',
              language: 'en',
              date_submitted: Date.today
            }
          ),
          id: document.id,
          content: Rack::Test::UploadedFile.new(tempfile, "application/pdf")
        }
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return document reference id" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).not_to eq nil
        expect(parsed_response['id']).not_to eq document.id
      end

      it "should create the file upload" do
        parsed_response = JSON.parse(response.body)
        document_id = parsed_response['id']
        document = Documents::DocumentModel.find(BSON::ObjectId.from_string(document_id))
        expect(document.file.read).to eq "DATA GOES HERE"
      end
    end

    context "with invalid params" do
      let(:document) { FactoryBot.create(:documents_document_model) }
      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        post :update, params: {
          document: JSON.dump(document_type: ""),
          id: document.id,
          content: Rack::Test::UploadedFile.new(tempfile, "application/pdf")
        }
      end

      it "is invalid" do
        expect(response).to have_http_status("422")
      end
    end

    context "when unauthorized" do
      let(:document) { FactoryBot.create(:documents_document_model) }
      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_failed)
        post :update, params: {
          document: JSON.dump(document_type: ""),
          id: document.id,
          content: Rack::Test::UploadedFile.new(tempfile, "application/pdf")
        }
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "#show" do
    let(:document) { FactoryBot.create(:documents_document_model) }
    context "succesful with valid params" do
      let(:document_json) { {} }

      let(:find_success) do
        double(
          success?: true,
          value!: document_json
        )
      end

      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        allow(Documents::Show).to receive(:call).with(
          id: document.id,
          authorization: authorization_information
        ).and_return(find_success)
        get :show, params: { id: document.id }
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return document metadata" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_an_instance_of(Hash)
      end
    end

    context "when unauthorized" do
      before :each do
        get :show, params: { id: document.id }
      end

      it "is forbidden" do
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "when not found" do
      let(:find_failure) do
        double(
          success?: false
        )
      end

      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        allow(Documents::Show).to receive(:call).with(
          id: document.id,
          authorization: authorization_information
        ).and_return(find_failure)
        get :show, params: { id: document.id }
      end

      it "is not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "#destroy" do
    let(:document) { FactoryBot.create(:documents_document_model) }
    context "succesful with valid params" do
      let(:document_json) { {} }

      let(:find_success) do
        double(
          success?: true
        )
      end

      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        allow(Documents::Destroy).to receive(:call).with(
          id: document.id
        ).and_return(find_success)
        delete :destroy, params: { id: document.id }
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when unauthorized" do
      before :each do
        delete :destroy, params: { id: document.id }
      end

      it "is forbidden" do
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "when not found" do
      let(:find_failure) do
        double(
          success?: false,
          failure: { errors: 'xyz' }
        )
      end

      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        allow(Documents::Destroy).to receive(:call).with(
          id: document.id
        ).and_return(find_failure)
        delete :destroy, params: { id: document.id }
      end

      it "is not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "#index" do
    let(:document_list) { [] }

    context "succesful with valid params" do
      let(:document_result) do
        double(success?: true, value!: document_list)
      end

      let(:requesting_identity_header_value) do
        "abcdefg"
      end

      let(:requesting_identity_signature_header_value) do
        "abcdefgsigned"
      end

      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: requesting_identity_header_value,
          requesting_identity_signature_header: requesting_identity_signature_header_value
        ).and_return(authorization_successful)
        allow(Documents::Where).to receive(:call).with(
          authorization_information
        ).and_return(document_result)
        request.headers["X-RequestingIdentity"] = requesting_identity_header_value
        request.headers["X-RequestingIdentitySignature"] = requesting_identity_signature_header_value
        get :index
      end

      it "should be success" do
        expect(response).to have_http_status(:ok)
      end

      it "should return document metadata array" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_an_instance_of(Array)
      end
    end

    context "failure with invalid params" do
      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_failed)
        get :index
      end

      it "should be success" do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "#download" do
    let(:document) do
      FactoryBot.create(
        :documents_document_model,
        file: tempfile
      )
    end

    context "succesful with valid params" do
      let(:download_success) do
        double(
          success?: true,
          value!: document
        )
      end

      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        get :download, params: { id: document.id }
      end

      it "is successful" do
        expect(response.status).to eq 200
      end

      it "presents the file" do
        content_disposition = response.headers["Content-Disposition"]
        content_pairs = content_disposition.split("; ").select { |h| h.include?("=") }.map do |h|
          h.split("=")
        end
        content_hash = Hash[content_pairs]
        expect(content_hash["filename"]).to eq("\"" + document.file.original_filename + "\"")
      end

      it "has the original file data" do
        expect(response.stream.body).to eq "DATA GOES HERE"
      end
    end

    context "when unauthorized" do
      before :each do
        get :download, params: { id: document.id }
      end

      it "is forbidden" do
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "when not found" do
      let(:download_failure) do
        double(
          success?: false
        )
      end

      before :each do
        allow(ValidateResourceIdentitySignature).to receive(:call).with(
          requesting_identity_header: nil,
          requesting_identity_signature_header: nil
        ).and_return(authorization_successful)
        allow(Documents::Download).to receive(:call).with(
          id: document.id,
          authorization: authorization_information
        ).and_return(download_failure)
        get :download, params: { id: document.id }
      end

      it "is not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
