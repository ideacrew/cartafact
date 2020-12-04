# frozen_string_literal: true

module Docs

  # A representation of a directory or folder in a file system
  class Folder < Dry::Struct

    # @!attribute [r] id
    # An unambiguous reference to this Folder
    # @return [String]
    attribute :id,          Types::String.meta(omittable: false)

    # @!attribute [r] name
    # A name given to this Folder
    # @return [String]
    attribute :name, Types::String.meta(omittable: false)

    # @!attribute [r] description
    # An optional description for this Folder
    # @return [String]
    attribute :description, Types::String.meta(omittable: true)

    # @!attribute [r] owner
    # The {Account} name of the owner of this Folder
    # @return [Account]
    attribute :owner,       Account.meta(omittable: false)

    # @!attribute [r] namespace
    # This Folder's position in the Folder tree
    # @return [Namespace]
    attribute :namespace,   Namespace..meta(omittable: false)

    # @!attribute [r] items
    # The list of items in this Folder
    # @return [Array<Item>]
    attribute :items,       Types::Array.of(Item).meta(omitttable: false)

    # @!attribute [r] kind
    # The type of resource.  Always :folder
    # @return [:folder]
    attribute :kind, Cartafact::Types::FolderKind.meta(omittable: false)

    # @!attribute [r] size
    # The Folder size in bytes
    # @return [Integer]
    attribute :size, Types::Integer.meta(omittable: true)

    # @!attribute [r] tags
    # Words or phrases assigned to a Folder for organizing and finding through search
    # @return [Array<Metadata::Tag>]
    attribute :tags, Metadata::Tag.meta(omittable: true)

    # @!attribute [r] created_at
    # The date and time when this Folder was created
    # @return [DateTime]
    attribute :created_at,  Types::DateTime.meta(omitttable: false)

    # @!attribute [r] updated_at
    # The date and time when this Folder was last modified
    # @return [DateTime]
    attribute :updated_at,  Types::DateTime.meta(omitttable: false)

    # @!attribute [r] expires_at
    # The time when this Folder will be automatically moved to Trash.
    # @return [DateTime]
    attribute :expires_at,  Types::DateTime.meta(omitttable: false)

    # @!attribute [r] purges_at
    # The time when this Folder is scheduled to be permanently deleted from Trash
    # @return [DateTime]
    attribute :purges_at,  Types::DateTime.meta(omitttable: false)

    # @!attribute [r] trashed_at
    # The time when this Folder was moved to Trash.
    # @return [DateTime]
    attribute :trashed_at,  Types::DateTime.meta(omitttable: false)


    attribute :metadata,      Metadata::CoreElements.meta(omitttable: false)
    attribute :permissions,   Metadata::CoreElements.meta(omitttable: false)

  end
end