require 'dry-struct'

module Cartafact
  module Entities
    class Document < Dry::Struct
      transform_keys(&:to_sym)

      attribute :subjects, ::Cartafact::Entities::Types::Coercible::Array.of(::Cartafact::Entities::Types::Hash)
      attribute? :path, ::Cartafact::Entities::Types::Any
      attribute? :document_type, ::Cartafact::Entities::Types::Coercible::String
      attribute? :id, ::Cartafact::Entities::Types::Coercible::String
      attribute? :title, ::Cartafact::Entities::Types::Coercible::String
      attribute? :identifier, ::Cartafact::Entities::Types::Coercible::String
      attribute? :description, ::Cartafact::Entities::Types::Coercible::String
      attribute? :language, ::Cartafact::Entities::Types::Coercible::String
      attribute? :format, ::Cartafact::Entities::Types::Coercible::String
      attribute? :date, ::Cartafact::Entities::Types::Coercible::String
    end
  end
end
