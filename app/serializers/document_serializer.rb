class DocumentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :creator, :identifier, :description, :language, :format, :source, :date, :creator

  attribute :type, &:document_type
  attribute :subjects, &:authorized_subjects

  attribute :version do |object|
    nil
  end

  attribute :id do |object|
    object.id.to_s
  end

  attribute :url do |object|
    url = Rails.env.production? ? object.file.url(response_content_disposition: 'attachment;') : ('/tmp' + object.file.url)
    Base64.encode64(url)
  end
end
