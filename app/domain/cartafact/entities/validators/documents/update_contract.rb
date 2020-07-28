module Cartafact
  module Entities
    module Validators
      module Documents
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
