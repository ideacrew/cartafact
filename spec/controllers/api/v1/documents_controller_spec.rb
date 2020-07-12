require 'rails_helper'

RSpec.describe Api::V1::DocumentsController, type: :controller do
  let(:tempfile) { Tempfile.new('test.pdf') }
  let(:key) { Rails.application.credentials[:enroll_dc] }
  let(:authorization_information) do
    instance_double(
      Cartafact::Entities::RequestingIdentity,
      authorized_subjects: []
    )
  end

  let(:authorization_successful) do
    double(success?: true, value!: authorization_information)
  end

  let(:authorization_failed) do
    double(success?: false)
  end

  before :each do
    allow(Cartafact::Operations::ValidateResourceIdentitySignature).to receive(:call).with(
      {
        requesting_identity_header: nil,
        requesting_identity_signature_header: nil
      }
    ).and_return(authorization_successful)
  end
  
  describe "#upload" do

    context "succesful with valid params" do

      before :each do
        post :upload, params: {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}], path: tempfile.path, document_type: 'vlp_doc'}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to eq ["success"]
      end

      it "should return document reference id" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys.include? 'reference_id').to eq true
      end
    end

    context "failure with invalid params" do

      before :each do
        post :upload, params: {authorized_subjects: [{id: 'abc', type: 'consumer'}], path: tempfile.path, document_type: 'vlp_doc'}
      end

      it "should be success" do
        expect(response).to have_http_status(:not_authorized)
      end
    end
  end

  describe "#find" do
    let(:document) {FactoryBot.create(:document)}
    context "succesful with valid params" do

      before :each do
        get :find, params: {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}], id: document.id}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["status"]).to eq "success"
      end

      it "should return document metadata" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['document']).to be_an_instance_of(Hash)
      end
    end

    context "failure with invalid params" do

      before :each do
        get :find, params: {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, id: document.id}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["status"]).to eq "failure"
      end

      it "should return failure message" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys.include? 'message').to eq true
      end

      it "should return empty hash as document" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['document']).to eq Hash.new
      end
    end
  end

  describe "#index" do
    let(:document_list) { [] }

    context "succesful with valid params" do
      let(:document_result) do
        double(success?: true, value!: document_list)
      end

      before :each do
        allow(Cartafact::Operations::ValidateResourceIdentitySignature).to receive(:call).with(
          {
            requesting_identity_header: nil,
            requesting_identity_signature_header: nil
          }).and_return(authorization_successful)
        allow(::Cartafact::Entities::Operations::Documents::Where).to receive(:call).with(authorization_information).and_return(document_result)
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
        allow(Cartafact::Operations::ValidateResourceIdentitySignature).to receive(:call).with(
          {
            requesting_identity_header: nil,
            requesting_identity_signature_header: nil
          }).and_return(authorization_failed)
          get :index
      end

      it "should be success" do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  # describe "#download" do

  #   context "succesful" do

  #     before :each do
  #       get :download, params: {bucket: "sbc-bucket", key: "1234"}
  #     end

  #     it "should be success" do
  #       expect(response).to have_http_status(:success)
  #     end

  #     it "should return json" do
  #       expect(response.content_type).to match "application/json"
  #     end

  #     it "should return success status" do
  #       result = JSON.parse(response.body)
  #       expect(result['status']).to eq "success"
  #     end
  #   end

  #   context "failure" do

  #     before :each do
  #       get :download, params: {bucket: "", key: ""}
  #     end

  #     it "should be success" do
  #       expect(response).to have_http_status(:success)
  #     end

  #     it "should return json" do
  #       expect(response.content_type).to match "application/json"
  #     end

  #     it "should return failure status" do
  #       result = JSON.parse(response.body)
  #       expect(result['status']).to eq "failure"
  #     end
  #   end
  # end
end