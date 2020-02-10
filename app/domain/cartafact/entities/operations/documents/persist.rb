module Cartafact
  module Entities
    module Operations
      module Documents
        class Persist

          include Dry::Transaction::Operation

          def call(input)
            document = ::Document.new(input.to_h)
            if document.save
              Success({message: 'Successfully created document', reference_id: document.id.to_s})
            else
              Failure({message: "Failed to create document with errors: #{document.errors.full_messages}"})
            end
          end
        end
      end
    end
  end
end

