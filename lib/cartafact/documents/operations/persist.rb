module Cartafact
  module Documents
    module Operations
      class Persist

        include Dry::Transaction::Operation

        def call(input)
          document = input[:document]
          if document.save
            Success({message: 'Successfully created document'})
          else
            Failure({message: "Failed to create document with errors: #{document.errors.full_messages}"})
          end
        end
      end
    end
  end
end
