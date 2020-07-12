module Cartafact
  module Entities
    module Validators
      module Documents
        class CreateContract < Dry::Validation::Contract
          params do
            required(:subjects).array(:hash) do
              required(:id).value(:string)
              required(:type).value(:string)
            end

            required(:document_type).value(:string)
            optional(:title).value(:string)
            optional(:identifier).value(:string)
            optional(:description).value(:string)
            optional(:language).value(:string)
            optional(:format).value(:string)
            optional(:date).value(:string)
            optional(:content_type).value(:string)
          end
        end
      end
    end
  end
end
