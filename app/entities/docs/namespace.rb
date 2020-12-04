# frozen_string_literal: true

#
class Docs::Namespace < Dry::Struct

  # @!attribute [r] ancestors
  # An ordered list of folder names that precede this Folder in the folder tree
  # @return [Array<String>]
  attribute :ancestors, Types::Array.of(Types::String).meta(omitttable: false)

  # The immediate anscestor that contains this Folder
  # @return [Folder]
  def parent
    ancestors.last
  end

  # The number of {ancestors} in the list
  # @return [Integer]
  def count
    ancestors.size
  end

end