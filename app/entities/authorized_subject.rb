# frozen_string_literal: true

# An Entity representing the subject of a document.
class AuthorizedSubject < Dry::Struct

  attribute :type, Cartafact::Entities::Types::Coercible::String
  attribute :id, Cartafact::Entities::Types::Coercible::String
end
