# frozen_string_literal: true

module Cartafact
  module Entities
    # Represents an identity making requests for a document.
    #
    # Includes authorized subjects and information about the system asserting the identity.
    class RequestingIdentity < Dry::Struct
      transform_keys(&:to_sym)

      attribute? :authorized_subjects, Cartafact::Entities::Types::Coercible::Array.of(
        Cartafact::Entities::AuthorizedSubject
      )
      attribute :authorized_identity, AuthorizedIdentity
    end
  end
end
