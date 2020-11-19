# frozen_string_literal: true

module Cartafact
  module Entities
    module Validators
      module Documents
        # Validates the provided parameters required to update
        class UpdateContract < Dry::Validation::Contract
          params do
            required(:id).value(:string)
            required(:path).value(:any)
          end
        end
      end
    end
  end
end
