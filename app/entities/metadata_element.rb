# frozen_string_literal: true

CARTAFACT_ELEMENT_NAMESPACE = 'http://cartafact.org/elements'

class MetadataElement < Dry::Struct

  # @!attribute [r] key
  # A token appended to the URI of the Cartafact namespace to create the URI of the term
  # @return [Symbol]
  attribute :key,           Types::Symbol.meta(omittable: false)

  # @!attribute [r] label
  # The human-readable label assigned to the term.
  # @return [String]
  attribute :label,         Types::String.meta(omittable: false)

  # @!attribute [r] type
  # Property, class, datatype, or vocabulary encoding scheme
  # @return [Carafact::Types::DataType]
  attribute :type,          Carafact::Types::DataType.meta(omitttable: false)

  # @!attribute definition
  # A statement that represents the concept and essential nature of the term
  # @return [String]
  attribute :definition,    Types::String.meta(omittable: true)

  # @!attribute comment
  # Additional information about the term or its application
  # @return [String]
  attribute :commment,      Types::String.meta(omittable: true)


  def uri
    [CARTAFACT_ELEMENT_NAMESPACE, key].join('/')
  end

end