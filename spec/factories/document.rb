FactoryBot.define do
  factory :document do
    authorized_subjects { [{id: 'abc', type: 'consumer'}] }
    authorized_identity  {{user_id: 'abc', system: 'enroll_dc'}}
    document_type { 'vlp_doc' }
    file_data {"{\"id\":\"eb0a625efa7e812955e61c5d0540337b.png\",\"storage\":\"store\",\"metadata\":{\"filename\":\"test.png\",\"size\":236744,\"mime_type\":null}}"}
  end
end
