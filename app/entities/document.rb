# frozen_string_literal: true

# Represents the document domain object.
class Document < Dry::Struct

  attribute :body,              Types::Any.meta(omittable: false)
  attribute :storage_location  # reference to data store
  attribute :core_metadata,     Metadata::CoreElements.meta(ommittable: false)
  attribute :version,           Types::Integer.meta(ommittable: false)

end
