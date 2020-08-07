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
            required(:path).value(:any)
            optional(:creator).value(:string)
            optional(:publisher).value(:string)
            required(:type).filled(Cartafact::Entities::Types::DcmiType)
            required(:format).value(:string)
            optional(:source).value(:string)
            optional(:language).value(:string)
            optional(:date_submitted).value(:date)
            optional(:title).value(:string)
            optional(:identifier).value(:string)
            optional(:description).value(:string)
            optional(:contributor).value(:string)
            optional(:created).value(:date)
            optional(:date_accepted).value(:date)
            optional(:expire).value(:date)
            optional(:relation).value(:string)
            optional(:coverage).value(:string)
            optional(:tags).value(:string)
            optional(:rights).value(:string)
            optional(:access_rights).value(:string)
            optional(:extent).value(:string)
            optional(:file_data).value(:string)
          end
        end
      end
    end
  end
end
