require 'rails_helper'

RSpec.describe Documents::FindContract do
  let(:subject) { Documents::FindContract.new.call(attrs) }
  let(:document) { FactoryBot.create(:documents_document_model) }

  context 'with valid params' do
    let(:attrs) do
      {
        authorized_identity: {
          user_id: 'abc', system: 'enroll_dc'
        },
        authorized_subjects: [{ subject_id: 'abc', subject_type: 'consumer' }], id: document.id.to_s
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

    it "should be a failure with error keys as :authorized_subjects, :authorized_identity, :id" do
      expect(subject.errors.to_h.keys).to eq [:authorized_subjects, :authorized_identity, :id]
    end
  end
end
