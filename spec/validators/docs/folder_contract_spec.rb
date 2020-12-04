# frozen_string_literal: true

require "rails_helper"

RSpec.describe Docs::FolderContract do

  let(:id)            { "abc123def" }
  let(:name)          { "Folder entity name" }
  let(:description)   { "Folder entitiy description" }
  let(:owner)         { attributes_for(:account) }
  let(:created_by)    { attributes_for(:account) }
  let(:namespace)     { attributes_for(:docs_namespace) }

  let(:kind)          { 'file' }
  let(:status)        { 'active' }
  let(:size)          { 85478741128 }
  let(:tags)          { [attributes_for(:metadata_tag)] }

  let(:created_at)    { DateTime.now - 1.day }
  let(:updated_at)    { created_at + 1.hour }
  let(:expires_at)    { created_at + 1.year }
  let(:trashed_at)    { created_at + 1.year }
  let(:purged_at)     { trashed_at + 1.day }

  let(:required_params) {
    {
      id: id,
      name: name,
      owner: owner,
      created_by: created_by,
      namespace: namespace,
      kind: kind,
      status: status,
      size: size,
      created_at: created_at,
      updated_at: updated_at,
      }
    }

  let(:optional_params) {
    {
      description: description,
      tags: tags,
      expires_at: expires_at,
      purged_at: purged_at,
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
