require "dry/transaction/operation"

module Cartafact
  module Entities
    module Operations
      module Documents
        class Upload

          include Dry::Transaction::Operation

          def call(input)
            result = Validators::Documents::UploadContract.new.call(input)

            if result.success?
              entity = Cartafact::Entities::Document.new(result.to_h)
              Persist.new.call(entity)
            else
              Failure({errors: result.errors.to_h})
            end
          end
        end
      end
    end
  end
end
