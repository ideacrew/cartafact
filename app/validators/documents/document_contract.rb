# frozen_string_literal: true

require 'mime/types'

module Documents

  # Schema and validation rules for the {Documents::Resource} entity
  class DocumentContract < ApplicationContract

    # @!method call(opts)
    # @param [Hash] opts the parameters to validate using this contract
    # @option opts [String] :identifier required
    # @option opts [CovidMost::Types::DcmiType] :type required
    # @option opts [String] :format required
    # @option opts [String] :source required
    # @option opts [Symbol] :language required
    # @option opts [Array<String>] :subject
    # @option opts [String] :creator required
    # @option opts [String] :publisher required
    # @option opts [DateTime] :date_submitted required
    # @option opts [DateTime] :created
    # @option opts [String] :title
    # @option opts [String] :contributor
    # @option opts [String] :description
    # @option opts [String] :coverage
    # @option opts [Date] :date
    # @option opts [DateTime] :date_accepted
    # @option opts [String] :valid
    # @option opts [String] :relation
    # @option opts [Array<String>] :rights
    # @option opts [Array<String>] :access_rights
    # @option opts [String] :extent

    # @return [Dry::Monads::Result] result
    params do
      required(:identifier).maybe(:string)
      required(:type).maybe(Types::DcmiType)
      required(:format).maybe(:string)
      required(:source).maybe(:string)
      required(:language).maybe(:symbol)

      required(:creator).maybe(:string)
      required(:publisher).maybe(:string)
      required(:date_submitted).maybe(:date_time)

      optional(:title).maybe(:string)
      optional(:contributor).maybe(:string)

      optional(:subject).maybe(:array)
      optional(:description).maybe(:string)
      optional(:coverage).maybe(:string)

      optional(:date).maybe(:date)
      optional(:created).maybe(:date_time)
      optional(:date_accepted).maybe(:date_time)
      optional(:valid).maybe(:string)

      optional(:relation).maybe(:string)
      optional(:rights).maybe(:array)
      optional(:access_rights).maybe(:array)
      optional(:extent).maybe(:string)
    end

    rule(:format) do
      key.failure("unknown Mime type: #{value}") unless ::MIME::Types[value].size > 0
    end

  end
end
