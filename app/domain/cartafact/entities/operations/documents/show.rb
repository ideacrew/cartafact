module Cartafact
  module Entities
    module Operations
      module Documents
        class Show
          include Dry::Monads[:result]

          def self.call(opts)
            self.new.call(opts)
          end

          def call(opts)
            documents = ::Document.where(
              "_id" => bson_id_from_params(opts[:id])
            )
            return Failure(:document_not_found) if documents.empty?
            Success(
              ::DocumentSerializer.new(documents.first).serializable_hash[:data][:attributes]
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