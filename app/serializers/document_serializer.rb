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
    Base64.encode64('/tmp' + object.file.url)
  end
end
