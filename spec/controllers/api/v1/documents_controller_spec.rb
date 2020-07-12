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
  
  describe "#create" do

    context "succesful with valid params" do

      before :each do
        allow(Cartafact::Operations::ValidateResourceIdentitySignature).to receive(:call).with(
          {
            requesting_identity_header: nil,
            requesting_identity_signature_header: nil
          }
        ).and_return(authorization_successful)
        post :create, params: {subjects: [{id: 'abc', type: 'consumer'}], path: tempfile.path, document_type: 'vlp_doc'}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return document reference id" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).not_to eq nil
      end
    end

    context "with invalid params" do

      before :each do
        allow(Cartafact::Operations::ValidateResourceIdentitySignature).to receive(:call).with(
          {
            requesting_identity_header: nil,
            requesting_identity_signature_header: nil
          }
        ).and_return(authorization_successful)
        post :create, params: {}
      end

      it "is invalid" do
        expect(response).to have_http_status("422")
      end
    end

    context "when unauthorized" do

      before :each do
        allow(Cartafact::Operations::ValidateResourceIdentitySignature).to receive(:call).with(
          {
            requesting_identity_header: nil,
            requesting_identity_signature_header: nil
          }
        ).and_return(authorization_failed)
        post :create, params: {subjects: [{id: 'abc', type: 'consumer'}], path: tempfile.path, document_type: 'vlp_doc'}
      end

      it "should be unauthorized" do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "#show" do
    let(:document) {FactoryBot.create(:document)}
    context "succesful with valid params" do
      let(:document_json) { {} }

      let(:find_success) do
        double(
          success?: true,
          value!: document_json
        )
      end

      before :each do
        allow(Cartafact::Operations::ValidateResourceIdentitySignature).to receive(:call).with(
          {
            requesting_identity_header: nil,
            requesting_identity_signature_header: nil
          }
        ).and_return(authorization_successful)
        allow(::Cartafact::Entities::Operations::Documents::Show).to receive(:call).with({
          id: document.id,
          authorization: authorization_information
        }).and_return(find_success)
        get :show, params: {id: document.id}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        parsed_response = JSON.parse(response.body)
      end

      it "should return document metadata" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to be_an_instance_of(Hash)
      end
    end

    context "when unauthorized" do

      before :each do
        get :show, params: { id: document.id}
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
        allow(Cartafact::Operations::ValidateResourceIdentitySignature).to receive(:call).with(
          {
            requesting_identity_header: nil,
            requesting_identity_signature_header: nil
          }
        ).and_return(authorization_successful)
        allow(::Cartafact::Entities::Operations::Documents::Show).to receive(:call).with({
          id: document.id,
          authorization: authorization_information
        }).and_return(find_failure)
        get :show, params: { id: document.id}
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