module Cartafact
  module Documents
    module Transactions
      class Create
        include Dry::Transaction(container: ::DocStorage)

        step :init
        step :transfer, with: 'cartafact.documents.operations.transfer'
        step :persist, with: 'cartafact.documents.operations.persist'

        private

        def init(input)
          document = Document.new(input.except(:path))
          document.file = File.open(input[:path])
          Success({document: document})
        end
      end
    end
  end
end
