# frozen_string_literal: true

require 'dry-struct'

module Cartafact
  module Entities
    # Represents the document domain object.
    class Document < Dry::Struct
      transform_keys(&:to_sym)

      attribute :subjects, ::Cartafact::Entities::Types::Coercible::Array.of(::Cartafact::Entities::Types::Hash)
      attribute? :creator, ::Cartafact::Entities::Types::Coercible::String
      attribute? :publisher, ::Cartafact::Entities::Types::Coercible::String
      attribute :type, ::Cartafact::Entities::Types::DcmiType
      attribute :format, ::Cartafact::Entities::Types::Coercible::String
      attribute? :source, ::Cartafact::Entities::Types::Coercible::String
      attribute? :language, ::Cartafact::Entities::Types::Coercible::String
      attribute? :date_submitted, ::Cartafact::Entities::Types::Nominal::Date
      attribute? :path, ::Cartafact::Entities::Types::Any
      attribute? :document_type, ::Cartafact::Entities::Types::Coercible::String
      attribute? :id, ::Cartafact::Entities::Types::Coercible::String
      attribute? :title, ::Cartafact::Entities::Types::Coercible::String
      attribute? :identifier, ::Cartafact::Entities::Types::Coercible::String
      attribute? :description, ::Cartafact::Entities::Types::Coercible::String
      attribute? :date, ::Cartafact::Entities::Types::Coercible::String
      attribute? :contributor, ::Cartafact::Entities::Types::Coercible::String
      attribute? :created, ::Cartafact::Entities::Types::Nominal::Date
      attribute? :date_accepted, ::Cartafact::Entities::Types::Nominal::Date
      attribute? :expire, ::Cartafact::Entities::Types::Nominal::Date
      attribute? :relation, ::Cartafact::Entities::Types::Coercible::String
      attribute? :coverage, ::Cartafact::Entities::Types::Coercible::String
      attribute? :tags, ::Cartafact::Entities::Types::Coercible::String
      attribute? :rights, ::Cartafact::Entities::Types::Coercible::String
      attribute? :access_rights, ::Cartafact::Entities::Types::Coercible::String
      attribute? :extent, ::Cartafact::Entities::Types::Coercible::String
      attribute? :file_data, ::Cartafact::Entities::Types::Coercible::String
    end
  end
end
