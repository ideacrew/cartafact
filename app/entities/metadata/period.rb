# frozen_string_literal: true

module Metadata

    # An interval in time
  class Period < Dry::Struct

    # @!attribute [r] name
    # A name for the time interval
    # @return [String]
    attribute :name,    Types::String.meta(omittable: true)

    # @!attribute [r] start
    # The instant corresponding to the commencement of the time interval
    # @return [DateTime]
    attribute :start,   Types::DateTime.meta(omittable: true)

    # @!attribute [r] end
    # The instant corresponding to the termination of the time interval
    # @return [DateTime]
    attribute :end,     Types::DateTime.meta(omittable: true)

    # @!attribute [r] scheme
    # The encoding used for the representation of the time-instants in the
    # start and end components (e.g. W3C-DTF)
    # @return [DateTime]
    attribute :scheme,  Types::String.meta(omittable: true)
  end
end
