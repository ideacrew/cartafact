module Cartafact
  module Documents
    module Operations
      class Transfer

        include Dry::Transaction::Operation

        def call(input)
          Success(input)
        end
      end
    end
  end
end
