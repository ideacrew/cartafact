module Cartafact
  module Documents
    class Upload
      include Dry::Transaction(container: ::DocStorage)

      step :parse
      step :validate, with: 'cartafact.documents.validations.validate_create'
      step :create, with: 'cartafact.documents.transactions.create'

      private

      def parse(input)
        Success(input)
      end

      def validate(input)
        result = super(input)
        if result.success?
          Success(input)
        else
          Failure(result.errors)
        end
      end
    end
  end
end
