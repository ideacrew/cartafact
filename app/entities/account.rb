# frozen_string_literal: true

# An identity for a machine or person who may access this system
class Account < Dry::Struct

  # @!attribute [r] id
  # An unambiguous reference to this Account
  # @return [String]
  attribute :id, Types::String.meta(omittable: false)

  # @!attribute [r] name
  # The name of the owner of this Account
  # @return [String]
  attribute :name, Types::String.meta(omittable: false)

  # @!attribute [r] kind
  # The type of resource.  Always 'account'
  # @return [Cartafact::Types::AccountKind]
  attribute :kind, Cartafact::Types::AccountKind.meta(omittable: false)

  # @!attribute [r] login
  # The unique Account name for this user (typically email)
  # @example
  #   "username@example.com"
  # @return [Cartafact::Types::EmailKind]
  attribute :login, Cartafact::Types::EmailKind.meta(omittable: false)

end