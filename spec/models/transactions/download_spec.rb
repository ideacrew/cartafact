require 'rails_helper'

RSpec.describe 'Transactions::Download', type: :transaction do

  let!(:subject) {Transactions::Download.new.call(attrs)}

  context "succesful" do

    let(:attrs) do
      {
        bucket: "sbc-bucket",
        key: "1234"
      }
    end

    it "should be success" do
      expect(subject.success?).to eq true
    end

    it "should return object" do
    end

    it "should return success message" do
      expect(subject.success[:message]).to eq "Successfully retrieved documents."
    end
  end

  context "failure" do

    context "with blank bucket/key" do

      let(:attrs) do
        {
          bucket: "",
          key: ""
        }
      end

      it "should be failure" do
        expect(subject.failure?).to eq true
      end

      it "should not return any object" do
      end

      it "should return failure message" do
        expect(subject.failure[:message]).to match "Bucket/Key should not be blank"
      end
    end

    context "with invalid key" do
      
    end
  end  
end
