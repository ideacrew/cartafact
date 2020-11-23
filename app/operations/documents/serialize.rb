# frozen_string_literal: true

module Documents
  # Serialize a document resource to a "showable" hash.
  class Serialize
    include Dry::Transaction::Operation

    def call(input)
      result = ::DocumentSerializer.new(input).serializable_hash[:data][:attributes]
      Success(result)
    end
  end
end
