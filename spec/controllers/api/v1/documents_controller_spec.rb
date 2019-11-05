require 'rails_helper'

RSpec.describe Api::V1::DocumentsController, type: :controller do
  
  describe "#upload" do
    before :each do
    end

    context "succesful" do

      it "should be success" do
      end

      it "should return json" do
      end

      it "should return success message" do
      end
    end

    context "failure" do

      it "should be success" do
      end

      it "should return json" do
      end

      it "should return failure message" do
      end
    end
  end

  describe "#download" do

    context "succesful" do

      before :each do
        get :download, params: {bucket: "sbc-bucket", key: "1234"}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        expect(response.content_type).to match "application/json"
      end

      it "should return success status" do
        result = JSON.parse(response.body)
        expect(result['status']).to eq "success"
      end
    end

    context "failure" do

      before :each do
        get :download, params: {bucket: "", key: ""}
      end

      it "should be success" do
        expect(response).to have_http_status(:success)
      end

      it "should return json" do
        expect(response.content_type).to match "application/json"
      end

      it "should return failure status" do
        result = JSON.parse(response.body)
        expect(result['status']).to eq "failure"
      end
    end
  end
end