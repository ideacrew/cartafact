# frozen_string_literal: true

require "rails_helper"

RSpec.describe Docs::FileContract do

  let(:id)            { "abc123def" }
  let(:name)          { "Priority Item" }
  let(:description)   { "File entitiy description" }
  let(:extension)     { "pdf" }
  let(:format)        { "text/pdf" }
  let(:owner)         { attributes_for(:account) }

  let(:kind)          { 'file' }
  let(:status)        { 'active' }
  let(:sha1)          { "a9993e364706816aba3e25717850c26c9cd0d89d" }
  let(:size)          { 85478741128 }
  let(:tags)          { [attributes_for(:metadata_tag)] }

  let(:created_at)    { DateTime.now - 1.day }
  let(:updated_at)    { created_at + 1.hour }
  let(:expires_at)    { created_at + 1.year }
  let(:purges_at)     { nil }
  let(:trashed_at)    { nil }


  let(:required_params) {
    {
      id: id,
      name: name,
      format: format,
      owner: owner,
      kind: kind,
      status: status,
      sha1: sha1,
      size: size,
      created_at: created_at,
      updated_at: updated_at,
      }
    }

  let(:optional_params) {
    {
      description: description,
      extension: extension,
      tags: tags,
      expires_at: expires_at,
      purges_at: purges_at,
      trashed_at: trashed_at,
      }
    }
  let(:all_params)      { required_params.merge(optional_params) }

  context "Given gapped or invalid parameters" do
    context "and parameters are empty" do
      it { expect(subject.call({}).success?).to be_falsey }
      it { expect(subject.call({}).error?(required_params.keys.first.to_sym)).to be_truthy }
    end
  end

  context "Given valid parameters" do
    context "and required parameters only" do
      it { expect(subject.call(required_params).success?).to be_truthy }
      it { expect(subject.call(required_params).to_h).to eq required_params }
    end

    context "and required and optional parameters" do
      it { expect(subject.call(all_params).success?).to be_truthy }
      it { expect(subject.call(all_params).to_h).to eq all_params }
    end
  end
end
