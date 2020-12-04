# frozen_string_literal: true

# A list of files, folders, and web links in their mini representation.
class Item < Dry::Struct

  # An unambiguous reference to the Item
  # @return [String]
  attribute :id, Types::String.meta(omittable: false)

  # A name given to the Item by which the Item is formally known
  # @return [String]
  attribute :name, Types::String.meta(omittable: false)

  # The type of Item
  # @return [Cartafact::Types::ItemKind]
  attribute :kind, Cartafact::Types::ItemKind.meta(omittable: false)

  # The sort order for this Item
  # @return [Integer]
  attribute :sequence, Types::Integer.meta(omittable: true)


end
