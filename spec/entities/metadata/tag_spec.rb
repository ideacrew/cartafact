# frozen_string_literal: true

require "rails_helper"

RSpec.describe Metadata::Tag do

  let(:name)            { "Priority Item" }
  let(:description)     { "Preferred item flag" }
  let(:owner)           { build(:account).to_h }

  let(:required_params) { { name: name, owner: owner } }
  let(:optional_params) { { description: description } }
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
        expect(@result.to_h).to eq all_params
      end
    end

    context 'and only required params are included' do
      before do
        @result = described_class.new(required_params)
      end

      it 'and its attributes should match input' do
        expect(@result.to_h).to eq required_params
      end
    end
  end

end
