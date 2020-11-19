# frozen_string_literal: true

module Cartafact
  module Entities
    module Operations
      module Documents
        # Update document metadata
        class Update
          include Dry::Monads[:result]

          def self.call(input)
            new.call(input)
          end

          def call(input)
            # WIP
            # contract_result = Validators::Documents::UpdateContract.new.call(input)
            # return Failure({ errors: contract_result.errors.to_h }) unless contract_result.success?

            # document = ::Document.where(
            #   "_id" => bson_id_from_params(input[:id])
            # ).first
            # return Failure(:document_not_found) if document.empty?

            # document.assign_attributes(path: input[:path])
            # if document.save
            #   Success(
            #     ::DocumentSerializer.new(document).serializable_hash[:data][:attributes]
            #   )
            # else
            #   Failure({ errors: document.errors.to_h })
            # end
          end

          def bson_id_from_params(id_string)
            BSON::ObjectId.from_string(id_string)
          end
        end
      end
    end
  end
end
