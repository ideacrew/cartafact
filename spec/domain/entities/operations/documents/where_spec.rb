# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cartafact::Entities::Operations::Documents::Where do
  let(:subject) { Cartafact::Entities::Operations::Documents::Where.new.call(authorization_information) }
  let(:document) { FactoryBot.create(:document, subjects: [{ subject_id: 'abc', subject_type: 'consumer' }]) }

  context 'with valid params but no matching documents' do
    let(:authorization_information) do
      instance_double(
        Cartafact::Entities::RequestingIdentity,
        authorized_subjects: []
      )
    end

    it "fails" do
      expect(subject.success?).to be_falsey
    end
  end

  context 'with valid params and matching documents' do
    let(:matching_subjects) do
      document.subjects.map do |d_sub|
        double(
          id: d_sub.subject_id,
          type: d_sub.subject_type
        )
      end
    end

    let(:authorization_information) do
      instance_double(
        Cartafact::Entities::RequestingIdentity,
        authorized_subjects: matching_subjects
      )
    end

    it "is successful" do
      expect(subject.success?).to be_truthy
    end

    it "has documents json response" do
      expect(subject.value!.first.keys.sort).to eq [
        :creator, :date, :description, :document_type, :extension, :format, :id, :identifier,
        :language, :mime_type, :size, :source, :subjects, :title, :version
      ]
    end

    it "properly serializes the subjects" do
      expect(subject.value!.first[:subjects]).to eq [{ id: 'abc', type: 'consumer' }]
    end
  end
end
