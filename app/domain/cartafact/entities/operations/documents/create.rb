module Cartafact
  module Entities
    module Operations
      module Documents
        class Create
          include Dry::Monads[:result]

          def self.call(input)
            self.new.call(input)
          end

          def call(input)
            contract_result = Validators::Documents::CreateContract.new.call(input)
            unless contract_result.success?
              return Failure({errors: contract_result.errors.to_h})
            end
            
            entity = Cartafact::Entities::Document.new(contract_result.values.to_h)
            persist_result = Persist.new.call(entity)
            unless persist_result.success?
              return Failure({errors: persist_result.failures})
            end
            Success(
              ::DocumentSerializer.new(persist_result.value!).serializable_hash[:data][:attributes]
            )
          end
        end
      end
    end
  end
end