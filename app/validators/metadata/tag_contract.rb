# frozen_string_literal: true

module Metadata
  # Schema and validation rules for {Tag} domain object
  class TagContract < ApplicationContract

    # @!method call(opts)
    # @param [Hash] opts the parameters to validate using this contract
    # @option opts [String] :name required
    # @option opts [Hash<Account>] :owner required
    # @option opts [String] :description optional
    # @return [Dry::Monads::Result] validation result
    params do
      required(:name).filled(:string)
      required(:owner).filled(:hash)
      optional(:description).maybe(:string)
    end

  end
end
