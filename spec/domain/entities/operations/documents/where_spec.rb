require 'rails_helper'

RSpec.describe Cartafact::Entities::Operations::Documents::Where do
  let(:subject) {Cartafact::Entities::Operations::Documents::Where.new.call(attrs)}
  let!(:document) {FactoryBot.create(:document, authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}])}

  context 'with valid params' do
    let(:attrs) {
      {authorized_identity: document.authorized_identity, authorized_subjects: document.authorized_subjects}
    }

    it "should be success" do
      expect(subject.success?).to be_truthy
    end

    it 'should return an documents array in response' do
      expect(subject.value![:documents]).to be_an_instance_of(Array)
    end

    it "should have documents json response" do
      expect(subject.value![:documents].first.keys.sort).to eq [:creator, :date, :description, :format, :id, :identifier, :language, :source, :subjects, :title, :type, :version]
    end
  end

  context 'with invalid params' do
    let(:attrs) {
      {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}}
    }

    it "should be failure" do
      expect(subject.success?).to be_falsey
    end

    it "should have documents response" do
      expect(subject.failure[:documents]).to eq []
    end
  end
end
