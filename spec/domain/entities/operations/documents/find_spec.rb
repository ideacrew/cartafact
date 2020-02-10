require 'rails_helper'

RSpec.describe Cartafact::Entities::Operations::Documents::Find do
  let(:subject) {Cartafact::Entities::Operations::Documents::Find.new.call(attrs)}
  let(:document) {FactoryBot.create(:document)}

  context 'with valid params' do
    let(:attrs) {
      {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}], id: document.id.to_s}
    }

    it "should be success" do
      expect(subject.success?).to be_truthy
    end

    it "should have document response" do
      expect(subject.value![:document].keys.sort).to eq [:creator, :date, :description, :extension, :format, :id, :identifier, :language, :size, :source, :subjects, :title, :type, :url, :version]
    end
  end

  context 'with invalid params' do
    let(:attrs) {
      {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, id: document.id.to_s}
    }

    it "should be failure" do
      expect(subject.success?).to be_falsey
    end

    it "should have document response as empty hash" do
      expect(subject.failure[:document]).to eq Hash.new
    end
  end
end
