# frozen_string_literal: true

module Cartafact
  module Entities
    class AuthorizedSubject < Dry::Struct
      transform_keys(&:to_sym)

      attribute :type, Cartafact::Entities::Types::Coercible::String
      attribute :id, Cartafact::Entities::Types::Coercible::String
    end
  end
end
