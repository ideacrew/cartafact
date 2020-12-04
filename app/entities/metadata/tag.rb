# frozen_string_literal: true

module Metadata

  # Metadata assigned to a single tag
  class Tag < Dry::Struct

    # @!attribute [r] name
    # Tag name (required)
    # @return [String]
    attribute :name,            Types::String.meta(omittable: false)

    # @!attribute [r] description
    # Short description for the tag. CommonMark syntax can be used for
    # rich text representation
    # @return [String]
    attribute :description,     Types::String.meta(omittable: true)

    # @!attribute [r] owner
    # Account that owns this tag instance
    # @return [String]
    attribute :owner,           Account.meta(omittable: false)
  end
end
