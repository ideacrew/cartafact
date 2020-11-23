# frozen_string_literal: true

class Group < Dry::Struct

  attribute :accounts, Types::Array.of(Account).meta(omitttable: false)

end