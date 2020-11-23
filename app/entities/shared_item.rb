# frozen_string_literal: true

class SharedItem < Dry::Struct

  attribute :item,        Types::Resource
  attribute :share_list,  Types::Array.of(Account).meta(omitttable: false)

end