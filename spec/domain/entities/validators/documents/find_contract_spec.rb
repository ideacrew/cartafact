require 'rails_helper'

RSpec.describe Cartafact::Entities::Validators::Documents::FindContract do
  let(:subject) {Cartafact::Entities::Validators::Documents::FindContract.new.call(attrs)}
  let(:document) {FactoryBot.create(:document)}

  context 'with valid params' do
    let(:attrs) {
      {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}], id: document.id.to_s}
    }

    it "should be success" do
      expect(subject.success?).to be_truthy
    end
  end

  context 'with invalid params' do
    let(:attrs) {
      {}
    }

    it "should be a failure with error keys as :authorized_subjects, :authorized_identity, :id" do
      expect(subject.errors.to_h.keys).to eq [:authorized_subjects, :authorized_identity, :id]
    end
  end
end
