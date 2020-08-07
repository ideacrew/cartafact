# frozen_string_literal: true

module Cartafact
  module Entities
    class AuthorizedIdentity < Dry::Struct
      transform_keys(&:to_sym)

      attribute :system, Cartafact::Entities::Types::Coercible::String
      attribute :user_id, Cartafact::Entities::Types::Coercible::String
    end
  end
end
