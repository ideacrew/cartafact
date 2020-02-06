module Cartafact
  module Documents
    class Download
      include Dry::Transaction(container: ::DocStorage)

      step :parse
      step :validate, with: 'cartafact.documents.validations.validate_find'
      step :find, with: 'cartafact.documents.transactions.find'

      private

      def parse(input)
        Success(input)
      end

      def validate(input)
        result = super(input)

        binding.pry

        if result.success?
          Success(input)
        else
          Failure(result.errors)
        end
      end
    end
  end
end
