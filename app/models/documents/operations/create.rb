# frozen_string_literal: true

module Documents
  module Operations
    class Create

      include Dry::Transaction::Operation

      def call(input)
        document = ::Entities::Document.new(input.to_h)
        Success(document)
      end
    end
  end
end
