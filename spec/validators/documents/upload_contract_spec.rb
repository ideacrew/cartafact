require 'rails_helper'

RSpec.describe Documents::UploadContract do
  let(:subject) { Documents::UploadContract.new.call(attrs) }
  let(:tempfile) { Tempfile.new('test.pdf') }

  context 'with valid params' do
    let(:attrs) do
      {
        authorized_identity: {
          user_id: 'abc', system: 'enroll_dc'
        },
        authorized_subjects: [{ subject_id: 'abc', subject_type: 'consumer' }], path: tempfile.path, document_type: 'vlp_doc'
      }
    end

    it "should be success" do
      expect(subject.success?).to be_truthy
    end
  end

  context 'with invalid params' do
    let(:attrs) do
      {}
    end

    it "should be a failure with error keys as :authorized_subjects, :authorized_identity, :path, :document_type" do
      expect(subject.errors.to_h.keys).to eq [:authorized_subjects, :authorized_identity, :path, :document_type]
    end
  end
end
