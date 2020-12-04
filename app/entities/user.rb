# frozen_string_literal: true

# A list of files, folders, and web links in their mini representation.
class User < Dry::Struct

  # An unambiguous reference to the Item
  # @return [String]
  attribute :id, Types::String.meta(omittable: false)

  # A name given to the Item by which the Item is formally known
  # @return [String]
  attribute :name, Types::String.meta(omittable: false)

  # The type of Item
  # @return [Cartafact::Types::ItemKind]
  attribute :kind, Cartafact::Types::ItemKind.meta(omittable: false)

  # The account name for this user
  # @example
  #   "username@example.com"
  # @return [String]
  attribute :login, Types::String.meta(omittable: true)

end