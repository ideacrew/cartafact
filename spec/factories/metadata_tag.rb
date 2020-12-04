# frozen_string_literal: true

FactoryBot.define do
  factory :metadata_tag, class: Metadata::Tag do
    initialize_with  { new(attributes) }

    name        { 'Tag Name attribute' }
    owner       { build(:account) }
    description { 'Description of a tag attribute' }

  end
end
