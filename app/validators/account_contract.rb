# frozen_string_literal: true

# Schema and validation rules for {Account} domain object
class AccountContract < ApplicationContract

  # @!method call(opts)
  # @param [Hash] opts the parameters to validate using this contract
  # @option opts [String] :id required
  # @option opts [String] :name required
  # @option opts [String] :kind required
  # @option opts [String] :login required
  # @return [Dry::Monads::Result] validation result
  params do
    required(:id).filled(:string)
    required(:name).filled(:string)
    required(:kind).filled(:string)
    required(:login).filled(Cartafact::Types::EmailKind)
  end

end
