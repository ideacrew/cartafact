
module Cartafact
  module Validators
    class RequestingIdentityContract < Dry::Validation::Contract
      params do
        optional(:authorized_subjects).array(:hash) do
          required(:id).value(:string)
          required(:type).value(:string)
        end

        required(:authorized_identity).hash do
          required(:user_id).value(:string)
          required(:system).value(:string)
        end
      end
    end
  end
end