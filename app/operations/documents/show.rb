# frozen_string_literal: true

module Documents
  # Find and serialize a known document resource
  class Show
    include Dry::Monads[:result]

    def self.call(opts)
      new.call(opts)
    end

    def call(opts)
      documents = Documents::Document.where(
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

