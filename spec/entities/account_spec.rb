# frozen_string_literal: true

require "rails_helper"

RSpec.describe Account do

  let(:id)    { "abc123def" }
  let(:name)  { "Elmer Fudd" }
  let(:kind)  { "account" }
  let(:login) { "elmer.fudd@loonytunes.com" }

  let(:required_params) { { id: id, name: name, kind: kind, login: login, } }
  let(:optional_params) { { } }
  let(:all_params)      { required_params.merge(optional_params) }


  context 'with valid params' do
    context 'and all params are included' do
      before do
        @result = described_class.new(all_params)
      end

      it "should return an #{described_class} object" do
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
