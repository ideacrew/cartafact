# frozen_string_literal: true

# Schema and validation rules for {Folder} domain object
class Docs::FolderContract < ApplicationContract

  # @!method call(opts)
  # @param [Hash] opts the parameters to validate using this contract
  # @option opts [String] :id required
  # @option opts [String] :name required
  # @option opts [String] :description optional
  # @option opts [Account] :owner required
  # @option opts [Account] :created_by required
  # @option opts [Docs::Namspace] :namespace required
  # @option opts [Array<Item>] :items required
  # @option opts [Cartafact::Types::FolderKind] :kind required
  # @option opts [Cartafact::Types::ItemStatusKind] :status required
  # @option opts [integer] :size required
  # @option opts [Array<Metadata::Tag>] :tags required
  # @option opts [DateTime] :created_at required
  # @option opts [DateTime] :updated_at required
  # @option opts [DateTime] :expires_at optional
  # @option opts [DateTime] :purged_at optional
  # @option opts [DateTime] :trashed_at optional
  # @return [Dry::Monads::Result] validation result
  params do
    required(:id).filled(:string)
    required(:name).filled(:string)
    optional(:description).maybe(:string)
    required(:owner).filled(:hash)
    required(:created_by).filled(:hash)
    required(:namespace).filled(:hash)
    required(:kind).filled(Cartafact::Types::FileKind)
    required(:status).filled(Cartafact::Types::ItemStatusKind)
    required(:size).filled(:integer)
    optional(:tags).maybe(:array)
    required(:created_at).filled(:date_time)
    required(:updated_at).filled(:date_time)
    optional(:expires_at).maybe(:date_time)
    optional(:purged_at).maybe(:date_time)
    optional(:trashed_at).maybe(:date_time)
  end

end
