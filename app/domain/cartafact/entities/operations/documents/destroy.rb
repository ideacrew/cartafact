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
            id = yield bson_id_from_params(input[:id])
            document = yield get_document(id.value!)
            action = yield destroy_document(document.value!)
            Success()
          end

          def bson_id_from_params(id_string)
            Try do
              Success(BSON::ObjectId.from_string(id_string))
            end
          end

          def get_document(id)
            Try do
              document = ::Document.where(
                "_id" => bson_id_from_params(id)
              ).first

              if document.present?
                Success(document)
              else
                Failure(:document_not_found)
              end
            end
          end

          def destroy_document(document)
            Try do
              document.destroy!
              Success()
            end.or(Failure(document.errors.to_h))
          end
        end
      end
    end
  end
end
