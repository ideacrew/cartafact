# frozen_string_literal: true

# Enables {File} versions and tracking
class Docs::FileVersion < Dry::Struct

  # @!attribute [r] id
  # An unambiguous reference to this File resource
  # @return [String]
  attribute :id, Types::String.meta(omittable: false)

  # @!attribute [r] name
  # A name given to this File
  # @return [String]
  attribute :name, Types::String.meta(omittable: false)

  # @!attribute [r] kind
  # The type of resource.  Always 'version'
  # @return ['version']
  attribute :kind, Types::String.meta(omittable: false)

  # @!attribute [r] sha1
  # The SHA1 hash of the file. May be use to compare the local file with Cartafact file contents
  # @return [String]
  attribute :sha1, Types::String.meta(omittable: false)

  # @!attribute [r] size
  # The File size in bytes
  # @return [Integer]
  attribute :size, Types::Integer.meta(omittable: false)

    # @!attribute [r] created_at
  # The date and time when this File was created
  # @return [DateTime]
  attribute :created_at,  Types::DateTime.meta(omitttable: false)

  # @!attribute [r] updated_at
  # The date and time when this File was last modified
  # @return [DateTime]
  attribute :updated_at,  Types::DateTime.meta(omitttable: false)

    # @!attribute [r] purged_at
  # The time when this File is expected to be permanently deleted from Trash.
  # May be null if expiration is not scheduled
  # @return [DateTime]
  attribute :purged_at?,  Types::DateTime.optional.meta(omitttable: true)

  # @!attribute [r] trashed_at
  # The time when this File was moved to Trash.
  # @return [DateTime]
  attribute :trashed_at?,  Types::DateTime.optional.meta(omitttable: true)


  # @!attribute [r] restored_at
  # The time when this File is expected to be permanently deleted from Trash.
  # May be null if expiration is not scheduled
  # @return [DateTime]
  attribute :restored_at?,  Types::DateTime.optional.meta(omitttable: true)

  # @!attribute [r] updated_by
  # The {Account} name that updated this File
  # @return [Account]
  attribute :updated_by, Account.meta(omittable: false)

  # @!attribute [r] restored_by
  # The {Account} name that restored this File
  # @return [Account]
  attribute :restored_by, Account.meta(omittable: false)

  # @!attribute [r] trashed_by
  # The {Account} name trashed this File
  # @return [Account]
  attribute :trashed_by, Account.meta(omittable: false)


end
