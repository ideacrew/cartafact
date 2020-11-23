# frozen_string_literal: true

# An entity authorized to access document resources.
class AuthorizedIdentity < Dry::Struct

  attribute :system, Cartafact::Entities::Types::Coercible::String
  attribute :user_id, Cartafact::Entities::Types::Coercible::String
end
