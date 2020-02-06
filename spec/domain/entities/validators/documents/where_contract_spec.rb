require 'rails_helper'

RSpec.describe Cartafact::Entities::Validators::Documents::WhereContract do
  let(:subject) {Cartafact::Entities::Validators::Documents::WhereContract.new.call(attrs)}

  context 'with valid params' do
    let(:attrs) {
      {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}]}
    }

    it "should be success" do
      expect(subject.success?).to be_truthy
    end
  end

  context 'with invalid params' do
    let(:attrs) {
      {}
    }

    it "should be a failure with error keys as :authorized_subjects, :authorized_identity" do
      expect(subject.errors.to_h.keys).to eq [:authorized_subjects, :authorized_identity]
    end
  end
end
