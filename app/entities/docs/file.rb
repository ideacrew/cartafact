# frozen_string_literal: true

# A representation of a file in a file system
class Docs::File < Dry::Struct

  # @!attribute [r] id
  # An unambiguous reference to this File resource
  # @return [String]
  attribute :id, Types::String.meta(omittable: false)

  # @!attribute [r] name
  # A name given to this File
  # @return [String]
  attribute :name, Types::String.meta(omittable: false)

  # @!attribute [r] extension
  # A extension given to this File
  # @return [String]
  attribute :extension, Types::String.optional.meta(omittable: true)

  # @!attribute [r] format
  # The format of File content.
  # Conforms to {http://www.iana.org/assignments/media-types/media-types.xhtml IANA mime types}
  # @example
  #   "application/pdf"
  # @return [String]
  attribute :format, Types::String.meta(omittable: false)

  # @!attribute [r] owner
  # The {Account} name of the owner of this File
  # @return [Account]
  attribute :owner, Account.meta(omittable: false)

  # @!attribute [r] description
  # An optional description for this File
  # @return [String]
  attribute :description, Types::String.optional.meta(omittable: true)

  # @!attribute [r] kind
  # The type of resource.  Always 'file'
  # @return ['file']
  attribute :kind, Types::String.meta(omittable: false)

  # @!attribute [r] status
  # The file's current state
  # @return [String]
  attribute :status, Types::String.meta(omittable: false)

  # @!attribute [r] sha1
  # The SHA1 hash of the file. May be use to compare the local file with Cartafact file contents
  # @return [String]
  attribute :sha1, Types::String.meta(omittable: false)

  # @!attribute [r] size
  # The File size in bytes
  # @return [Integer]
  attribute :size, Types::Integer.meta(omittable: false)

  # @!attribute [r] tags
  # Words or phrases assigned to a File for organizing and finding through search
  # @return [Array<Metadata::Tag>]
  attribute :tags, Types::Array.of(Metadata::Tag).optional.meta(omittable: true)

  # @!attribute [r] created_at
  # The date and time when this File was created
  # @return [DateTime]
  attribute :created_at,  Types::DateTime.meta(omitttable: false)

  # @!attribute [r] updated_at
  # The date and time when this File was last modified
  # @return [DateTime]
  attribute :updated_at,  Types::DateTime.meta(omitttable: false)

  # @!attribute [r] id
  # The time at which this File will be automatically deleted
  # @return [DateTime]
  attribute :expires_at?,  Types::DateTime.optional.meta(omitttable: true)

  # @!attribute [r] purged_at
  # The time when this File is expected to be permanently deleted from Trash.
  # May be null if expiration is not scheduled
  # @return [DateTime]
  attribute :purged_at?,  Types::DateTime.optional

  # @!attribute [r] trashed_at
  # The time when this File was moved to Trash.
  # @return [DateTime]
  attribute :trashed_at?,  Types::DateTime.optional.meta(omitttable: true)

  # require 'digest'
  # def size=()
  #   # Compute a complete digest
  #   Digest::SHA1.hexdigest 'abc'      #=> "a9993e36..."

  #   # Compute digest by chunks
  #   sha1 = Digest::SHA1.new               # =>#<Digest::SHA1>
  #   sha1.update "ab"
  #   sha1 << "c"                           # alias for #update
  #   sha1.hexdigest                        # => "a9993e36..."
  # end

end
