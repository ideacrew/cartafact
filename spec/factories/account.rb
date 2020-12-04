# frozen_string_literal: true

FactoryBot.define do
  factory :account, class: Account, aliases: [:owner] do
    initialize_with  { new(attributes) }

    id    { 'adby-kjl-oi89' }
    name  { 'John Doe' }
    kind  { 'account' }
    login { 'john.doe@example.com' }
  end
end
