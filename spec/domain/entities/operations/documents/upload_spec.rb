require 'rails_helper'

RSpec.describe Cartafact::Entities::Operations::Documents::Upload do
  let(:subject) {Cartafact::Entities::Operations::Documents::Upload.new.call(attrs)}
  let(:tempfile) { Tempfile.new('test.pdf') }

  context 'with valid params' do
    let(:attrs) {
      {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}], path: tempfile.path, document_type: 'vlp_doc'}
    }

    it "should be success" do
      expect(subject.success?).to be_truthy
    end
  end

  context 'with invalid params' do
    let(:attrs) {
      {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}], path: tempfile.path}
    }

    it "should be failure" do
      expect(subject.success?).to be_falsey
    end
  end
end
