# frozen_string_literal: true

module Cartafact
  module Entities
    module Operations
      module Documents
        # Download a document resource.
        class Download
          include Dry::Monads[:result]

          def self.call(opts)
            new.call(opts)
          end

          def call(opts)
            documents = ::Document.where(
              "_id" => bson_id_from_params(opts[:id])
            )
            return Failure(:document_not_found) if documents.empty?

            Success(
              documents.first
            )
          end

          def bson_id_from_params(id_string)
            BSON::ObjectId.from_string(id_string)
          end
        end
      end
    end
  end
end
