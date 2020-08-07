# frozen_string_literal: true

module Cartafact
  module Entities
    module Operations
      module Documents
        class Serialize
          include Dry::Transaction::Operation

          def call(input)
            result = ::DocumentSerializer.new(input).serializable_hash[:data][:attributes]
            Success(result)
          end
        end
      end
    end
  end
end
