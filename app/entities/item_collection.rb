# frozen_string_literal: true

# A list of files, folders
class ItemCollection < Dry::Struct

  # Items in this Collection
  # @return [Array<Item>]
  attribure :items,   Types::Array.of(Item).meta(omittable: true)

  # The number of Items in this collection
  # @return [Integer]
  attribute :count,   Types::Integer

end
