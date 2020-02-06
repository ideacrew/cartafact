class DocumentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :creator, :identifier, :description, :language, :format, :source, :date, :creator, :id

  attribute :type, &:document_type
  attribute :subjects, &:authorized_subjects

  attribute :version do |object|
    nil
  end
end
