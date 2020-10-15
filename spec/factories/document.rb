# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    document_type { 'vlp_doc' }
    file_data do
      "{\"id\":\"eb0a625efa7e812955e61c5d0540337b.png\",
      \"storage\":\"store\",
      \"metadata\":{\"filename\":\"test.png\",
      \"size\":236744,
      \"mime_type\":null}}"
    end
  end
end
