module Cartafact
  module Entities
    module Operations
      module Documents
        class Update
          include Dry::Monads[:result]

          # Use this operation to update document meta data.

          def self.call(input)
            self.new.call(input)
          end

          def call(input)
            contract_result = Validators::Documents::UpdateContract.new.call(input)
            unless contract_result.success?
              return Failure({errors: contract_result.errors.to_h})
            end

            document = ::Document.where(
              "_id" => bson_id_from_params(input[:id])
            ).first
            return Failure(:document_not_found) if document.empty?

            document.assign_attributes(path: input[:path])
            if document.save
              Success(
                ::DocumentSerializer.new(document).serializable_hash[:data][:attributes]
              )
            else
              Failure({errors: document.errors.to_h})
            end
          end

          def bson_id_from_params(id_string)
            BSON::ObjectId.from_string(id_string)
          end
        end
      end
    end
  end
end
