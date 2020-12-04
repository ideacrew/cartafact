# frozen_string_literal: true

require "rails_helper"

RSpec.describe Docs::File do

  let(:id)            { "abc123def" }
  let(:name)          { "Priority Item" }
  let(:description)   { "File entitiy description" }
  let(:extension)     { "pdf" }
  let(:format)        { "text/pdf" }
  let(:owner)         { build(:account) }

  let(:kind)          { 'file' }
  let(:status)        { 'active' }
  let(:sha1)          { "a9993e364706816aba3e25717850c26c9cd0d89d" }
  let(:size)          { 85478741128 }
  let(:tag)           { build(:metadata_tag) }
  let(:tags)          { [tag] }

  let(:created_at)    { DateTime.now - 1.day }
  let(:updated_at)    { created_at + 1.hour }
  let(:expires_at)    { created_at + 1.year }
  let(:trashed_at)    { expires_at + 1.day }
  let(:purges_at)     { trashed_at + 1.month }

  let(:child_model_params)  { { owner: owner.to_h, tags: [tag.to_h] } }

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

  context 'with valid params' do
    context 'and all params are included' do
      before do
        @result = described_class.new(all_params)
      end

      it "should return a #{described_class} object" do
        expect(@result).to be_a(described_class)
      end

      it 'and its attributes should match input' do
        all_params_compare_hash = all_params.merge!(child_model_params)
        expect(@result.to_h).to eq all_params_compare_hash
      end
    end

    context 'and only required params are included' do
      before do
        @result = described_class.new(required_params)
      end

      it 'and its attributes should match input' do
        required_params_compare_hash = required_params.merge!(owner: owner.to_h)
        expect(@result.to_h).to eq required_params_compare_hash
      end
    end
  end

end
