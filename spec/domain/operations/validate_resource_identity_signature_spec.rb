require "rails_helper"

module Cartafact
  module Operations
    RSpec.describe ValidateResourceIdentitySignature do
      subject do
        described_class.call(params)
      end

      describe "given empty :requesting_identity_header" do
        let(:params) do
          {
            requesting_identity_header: nil,
            requesting_identity_signature_header: "SOMETHING"
          }
        end

        it "fails" do
          expect(subject).not_to be_success
          expect(subject.failure).to eq :no_resource_identity_header
        end
      end

      describe "given empty :requesting_identity_signature_header" do
        let(:params) do
          {
            requesting_identity_header: "SOMETHING",
            requesting_identity_signature_header: nil
          }
        end

        it "fails" do
          expect(subject).not_to be_success
          expect(subject.failure).to eq :no_resource_identity_signature_header
        end
      end

      describe "given invalid json :requesting_identity_header" do
        let(:params) do
          {
            requesting_identity_header: Base64.strict_encode64("{ adsfk"),
            requesting_identity_signature_header: "SOMETHING"
          }
        end

        it "fails" do
          expect(subject).not_to be_success
          expect(subject.failure).to eq :invalid_resource_identity_json
        end
      end

      describe "given identity information with no data" do
        let(:params) do
          {
            requesting_identity_header: Base64.strict_encode64("{}"),
            requesting_identity_signature_header: "SOMETHING"
          }
        end

        it "fails" do
          expect(subject).not_to be_success
          expect(subject.failure).to eq :no_system_or_user_specified
        end
      end

      describe "given identity information with no data" do
        let(:params) do
          {
            requesting_identity_header: Base64.strict_encode64("{}"),
            requesting_identity_signature_header: "SOMETHING"
          }
        end

        it "fails" do
          expect(subject).not_to be_success
          expect(subject.failure).to eq :no_system_or_user_specified
        end
      end

      describe "given identity information with a bogus system" do
        let(:identity_data) do
          {
            authorized_identity: {
              system: "BOGUS",
              user_id: "some_id"
            }
          }
        end

        let(:params) do
          {
            requesting_identity_header: Base64.strict_encode64(JSON.dump(identity_data)),
            requesting_identity_signature_header: "SOMETHING"
          }
        end

        it "fails" do
          expect(subject).not_to be_success
          expect(subject.failure).to eq :no_such_system
        end
      end

      describe "given identity information with a valid system, but bogus signature" do
        let(:identity_data) do
          {
            authorized_identity: {
              system: "a_valid_system",
              user_id: "some_id"
            }
          }
        end

        let(:identity_header) { Base64.strict_encode64(JSON.dump(identity_data)) }

        let(:params) do
          {
            requesting_identity_header: identity_header,
            requesting_identity_signature_header: "SOMETHING"
          }
        end

        let(:key) do
          instance_double(
            ClientApplicationKey
          )
        end

        before :each do
          allow(ClientApplicationKey).to receive(:locate_keys).with("a_valid_system").and_return([key])
          allow(key).to receive(:valid_signature?).with(identity_header, Base64.decode64("SOMETHING")).and_return(false)
        end

        it "fails" do
          expect(subject).not_to be_success
          expect(subject.failure).to eq :invalid_signature
        end
      end

      describe "given identity information with a valid system and signature returns the identity data" do
        let(:identity_data) do
          {
            :authorized_identity => {
              :system => "a_valid_system",
              :user_id => "some_id"
            },
            :authorized_subjects => [
              {
                "id" => "12345",
                "type" => "Person"
              }
            ]
          }
        end

        let(:expected_value) do 
          Cartafact::Entities::RequestingIdentity.new(identity_data)
        end

        let(:identity_header) { Base64.strict_encode64(JSON.dump(identity_data)) }

        let(:params) do
          {
            requesting_identity_header: identity_header,
            requesting_identity_signature_header: "SOMETHING"
          }
        end

        let(:key) do
          instance_double(
            ClientApplicationKey
          )
        end

        before :each do
          allow(ClientApplicationKey).to receive(:locate_keys).with("a_valid_system").and_return([key])
          allow(key).to receive(:valid_signature?).with(identity_header, Base64.decode64("SOMETHING")).and_return(true)
        end

        it "passes and returns the identity data" do
          expect(subject).to be_success
          expect(subject.value!).to eq expected_value
        end
      end
    end
  end
end