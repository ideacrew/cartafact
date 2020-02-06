require 'dry-struct'

module Types
  include Dry.Types()
end

module Cartafact
  module Entities
    class Document < Dry::Struct
      transform_keys(&:to_sym)

      attribute :authorized_subjects, Types::Coercible::Array
      attribute :authorized_identity, Types::Coercible::Hash
      attribute? :path, Types::Coercible::String
      attribute? :document_type, Types::Coercible::String
      attribute? :id, Types::Coercible::String
      attribute? :title, Types::Coercible::String
      attribute? :identifier, Types::Coercible::String
      attribute? :description, Types::Coercible::String
      attribute? :language, Types::Coercible::String
      attribute? :format, Types::Coercible::String
      attribute? :date, Types::Coercible::String
      attribute? :content_type, Types::Coercible::String
    end
  end
end
