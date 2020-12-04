# frozen_string_literal: true

# Schema and validation rules for {File} domain object
class Docs::FileContract < ApplicationContract

  # @!method call(opts)
  # @param [Hash] opts the parameters to validate using this contract
  # @option opts [String] :id required
  # @option opts [String] :name required
  # @option opts [String] :description optional
  # @option opts [String] :extension optional
  # @option opts [String] :format optional
  # @option opts [Account] :owner required
  # @option opts [Cartafact::Types::FileKind] :kind required
  # @option opts [Cartafact::Types::FileStatus] :status required
  # @option opts [String] :sha1 required
  # @option opts [integer] :size required
  # @option opts [Array<Metadata::Tag>] :tags required
  # @option opts [DateTime] :created_at required
  # @option opts [DateTime] :updated_at required
  # @option opts [DateTime] :expires_at optional
  # @option opts [DateTime] :purges_at optional
  # @option opts [DateTime] :trashed_at optional

  # @return [Dry::Monads::Result] validation result
  params do
    required(:id).filled(:string)
    required(:name).filled(:string)
    optional(:description).maybe(:string)
    optional(:extension).maybe(:string)
    required(:format).filled(:string)
    required(:owner).filled(:hash)

    required(:kind).filled(Cartafact::Types::FileKind)
    required(:status).filled(Cartafact::Types::FileStatusKind)
    required(:sha1).filled(:string)
    required(:size).filled(:integer)
    optional(:tags).maybe(:array)

    required(:created_at).filled(:date_time)
    required(:updated_at).filled(:date_time)
    optional(:expires_at).maybe(:date_time)
    optional(:purges_at).maybe(:date_time)
    optional(:trashed_at).maybe(:date_time)
  end

end
