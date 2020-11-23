# frozen_string_literal: true

module Documents
  # Download a document resource.
  class Download
    send(:include, Dry::Monads[:result, :do])

    def self.call(opts)
      new.call(opts)
    end

    def call(opts)
      documents = Documents::Document.where(
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

