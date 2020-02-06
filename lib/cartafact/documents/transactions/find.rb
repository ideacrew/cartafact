module Cartafact
  module Documents
    module Transactions
      class Find
        include Dry::Transaction(container: ::DocStorage)

        step :find, with: 'cartafact.documents.operations.find'
      end
    end
  end
end
