require 'rails_helper'

RSpec.describe Api::V1::DocumentsController, type: :controller do
  let(:tempfile) { Tempfile.new('test.pdf') }
  let(:key) {Rails.application.credentials[:enroll_dc]}

  let(:authorization_successful) do
    double(success?: true)
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
        expect(parsed_response["status"]).to eq "success"
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
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["status"]).to eq "failure"
      end

      it "should return failure message" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys.include? 'errors').to eq true
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

  describe "#where" do
    let(:document) {FactoryBot.create(:document)}

    context "succesful with valid params" do

      before :each do
        get :where, params: {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}], id: document.id}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["status"]).to eq "success"
      end

      it "should return document metadata array" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['documents']).to be_an_instance_of(Array)
      end
    end

    context "failure with invalid params" do

      before :each do
        get :where, params: {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, id: document.id}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["status"]).to eq "failure"
      end

      it "should return empty array" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['documents']).to eq []
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