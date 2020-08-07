# frozen_string_literal: true

require 'base64'

module Cartafact
  module Operations
    # Validate the signatures provided for all types of document request.
    class ValidateResourceIdentitySignature
      include Dry::Monads[:result, :do, :try, :maybe, :list]

      def self.call(resource_identity_data)
        new.call(resource_identity_data)
      end

      def call(resource_identity_data)
        r_identity_b64 = resource_identity_data[:requesting_identity_header]
        r_identity_sig_b64 = resource_identity_data[:requesting_identity_signature_header]

        return Failure(:no_resource_identity_header) if r_identity_b64.blank?
        return Failure(:no_resource_identity_signature_header) if r_identity_sig_b64.blank?

        decoded_resource_identity = yield decode_values(r_identity_b64, :invalid_base64_resource_identity_content)
        decoded_resource_identity_signature = yield decode_values(
          r_identity_sig_b64,
          :invalid_base64_resource_identity_signature_content
        )
        identity_data = yield parse_data_json(decoded_resource_identity.value!)
        requested_identity = yield validate_requested_identity_params(identity_data.value!)
        jwt_app_keys = yield find_jwt_app_keys(requested_identity)
        _valid_key_found = yield check_signatures(
          jwt_app_keys,
          r_identity_b64,
          decoded_resource_identity_signature.value!
        )
        Success(requested_identity)
      end

      def decode_values(data, failure_value)
        Try do
          Success(Base64.decode64(data))
        end.or(Failure(failure_value))
      end

      def parse_data_json(data)
        Try do
          Success(JSON.parse(data))
        end.or(Failure(:invalid_resource_identity_json))
      end

      def validate_requested_identity_params(parsed_json)
        validator = Cartafact::Validators::RequestingIdentityContract.new
        validation_result = validator.call(parsed_json)
        return Failure(:no_system_or_user_specified) unless validation_result.success?

        Success(Cartafact::Entities::RequestingIdentity.new(validation_result.values))
      end

      def find_jwt_app_keys(requesting_identity)
        system_name = requesting_identity.authorized_identity.system
        keys = ClientApplicationKey.locate_keys(system_name)
        return Failure(:no_such_system) if keys.empty?

        Success(keys.to_a)
      end

      def check_signatures(keys, identity_data_as_b64, signature)
        validation_results = keys.any? do |key|
          key.valid_signature?(identity_data_as_b64, signature)
        end
        return Failure(:invalid_signature) unless validation_results

        Success(nil)
      end
    end
  end
end
