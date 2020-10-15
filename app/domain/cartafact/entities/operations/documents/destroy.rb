module Cartafact
  module Entities
    module Operations
      module Documents
        class Update
          include Dry::Monads[:result]

          def self.call(input)
            self.new.call(input)
          end

          def call(input)
            document = ::Document.where(
              "_id" => bson_id_from_params(input[:id])
            ).first
            return Failure(:document_not_found) if document.empty?

            if document.destroy!
              Success()
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
