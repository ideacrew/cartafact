# frozen_string_literal: true

FactoryBot.define do
  factory :documents_document_model, class: 'Documents::DocumentModel' do

    format          { 'text/pdf' }
    document_type   { 'vlp_doc' }
    # path            { 'Path metadata value' }
    date_submitted  { DateTime.now }
    identifier      { 'Identifier metadata value' }
    description     { 'Description metadata value' }
    contributor     { 'Contributor metadata value' }
    created         { DateTime.now - 2.days }
    date_accepted   { Date.today }
    expire          { Date.today + 1.year }
    relation        { 'Relation metadata value' }
    coverage        { 'Coverage metadata value' }
    tags            { ['Tags metadata value'] }
    access_rights   { ['AccessRights metadata value'] }
    extent          { ['Extent metadata value'] }

    # file_data do
    #   "{\"id\":\"eb0a625efa7e812955e61c5d0540337b.png\",
    #   \"storage\":\"store\",
    #   \"metadata\":{\"filename\":\"test.png\",
    #   \"size\":236744,
    #   \"mime_type\":null}}"
    # end
  end
end
