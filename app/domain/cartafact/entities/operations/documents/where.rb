require "dry/transaction/operation"

module Cartafact
  module Entities
    module Operations
      module Documents
        class Where

          include Dry::Transaction::Operation

          def call(input)
            result = Validators::Documents::WhereContract.new.call(input)

            if result.success?
              entity = Cartafact::Entities::Document.new(result.to_h)
              documents = ::Document.all.where(:"authorized_subjects".in => entity.authorized_subjects)

              return Failure({message: "No Documents found", meta_data: []}) if documents.blank?
              output = documents.inject([]) do |result, document|
                result << Serialize.new.call(document).value!
                result
              end
              Success({message: 'Successfully retrieved documents', documents: output})
            else
              Failure({errors: result.errors.to_h, documents: []})
            end
          end
        end
      end
    end
  end
end
