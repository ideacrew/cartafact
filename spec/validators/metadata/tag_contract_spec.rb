# frozen_string_literal: true

require "rails_helper"

RSpec.describe Metadata::TagContract do

  let(:name)            { "Priority Item" }
  let(:description)     { "Preferred item flag" }
  let(:owner)           { build(:account).to_h }

  let(:required_params) { { name: name, owner: owner } }
  let(:optional_params) { { description: description } }
  let(:all_params)      { required_params.merge(optional_params) }

  context "Given gapped or invalid parameters" do
    context "and parameters are empty" do
      it { expect(subject.call({}).success?).to be_falsey }
      it { expect(subject.call({}).error?(:name)).to be_truthy }
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
