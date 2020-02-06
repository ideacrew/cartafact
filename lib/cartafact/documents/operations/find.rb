module Cartafact
  module Documents
    module Operations
      class Find

        include Dry::Transaction::Operation

        def call(input)
          documents = Document.all.where(:"authorized_subjects".in => input[:authorized_subjects])
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
