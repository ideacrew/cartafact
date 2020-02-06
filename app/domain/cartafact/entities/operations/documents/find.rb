require "dry/transaction/operation"

module Cartafact
  module Entities
    module Operations
      module Documents
        class Find

          include Dry::Transaction::Operation

          def call(input)
            result = Validators::Documents::FindContract.new.call(input)

            if result.success?
              entity = Cartafact::Entities::Document.new(result.to_h)
              document = ::Document.all.where(:"authorized_subjects".in => entity.authorized_subjects, id: entity.id).first
              
              return Failure({message: "No Documents found", meta_data: []}) if document.blank?
              result = Serialize.new.call(document)
              Success({message: 'Successfully retrieved document', document: result.value!})
            else
              Failure({errors: result.errors.to_h, document: {}})
            end
          end
        end
      end
    end
  end
end
