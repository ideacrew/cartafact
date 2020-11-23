# frozen_string_literal: true

class account
  attribute :email,               CovidMost::Types::Email.meta(omittable: true)
end