# frozen_string_literal: true

class Folder < Dry::Struct

  # Persistent identifiers should be provided as HTTP URIs.
  # @return [String]
  attribute :id,          Types::String.meta(omittable: false)

  attribute :owner,       Account.meta(omittable: false)

  attribute :folders,     Types::Array.of(Folder).meta(omitttable: false)
  attribute :documents,   Types::Array.of(Document).meta(omitttable: false)

  attribute :creaated_at, Types::DateTime.meta(omitttable: false)
  attribute :updated_at,  Types::DateTime.meta(omitttable: false)

end