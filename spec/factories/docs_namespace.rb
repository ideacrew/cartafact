# frozen_string_literal: true

FactoryBot.define do
  factory :docs_namespace, class: Docs::Namespace do
    initialize_with  { new(attributes) }

    ancestors  { ['root', 'cover_me', 'notices', 'individual_market'] }

  end
end

