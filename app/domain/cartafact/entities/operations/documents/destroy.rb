# frozen_string_literal: true

module Cartafact
  module Entities
    module Operations
      module Documents
        # Destroy document
        class Destroy
          include Dry::Monads[:result, :do, :try, :maybe, :list]

          def self.call(input)
            new.call(input)
          end

          def call(input)
            id = yield bson_id_from_params(input[:id])
            document = yield get_document(id)
            action = yield destroy_document(document.value!)
            Success(action)
          end

          def bson_id_from_params(id_string)
            Success(BSON::ObjectId.from_string(id_string))
          end

          def get_document(id)
            Try do
              document = ::Document.where(
                "_id" => id
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
              if document.destroy!
                Success()
              else
                Failure(document.errors.to_h)
              end
            end
          end
        end
      end
    end
  end
end
