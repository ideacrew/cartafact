module Operations
  class Find

    include Dry::Transaction::Operation

    # Dependency injection for validate and document find.
    def call(input)
      document = find_document
      Success(document)
    end
  end
end
