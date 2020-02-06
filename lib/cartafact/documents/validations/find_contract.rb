# frozen_string_literal: true
module Cartafact
  module Documents
    module Validations
      FindContract = Cartafact::Validations::ApplicationContract.build do

        params do
          required(:authorized_subjects).array(:hash) do
            required(:id).value(:string)
            required(:type).value(:string)
          end

          required(:authorized_identity).hash do
            required(:user_id).value(:string)
            required(:system).value(:string)
          end

          optional(:document_type).value(:string)
        end
      end
    end
  end
end

# options = {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}]}
# Cartafact::Documents::Download.new.call(options)