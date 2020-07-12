class DocumentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :creator, :identifier, :description, :language, :format, :source, :date, :creator

  attribute :type, &:document_type
  attribute :subjects do |object|
    object.subjects.map do |subj|
      {
        id: subj.subject_id,
        type: subj.subject_type
      }
    end
  end

  attribute :version do |object|
    nil
  end

  attribute :id do |object|
    object.id.to_s
  end

=begin
  attribute :url do |object|
    url = Rails.env.production? ? object.file.url(response_content_disposition: 'attachment;') : ('/tmp' + object.file.url)
    Base64.encode64(url)
  end
=end

  attribute :extension do |object|
    if object.file
      object.file.extension
    end
  end

  attribute :size do |object|
    if object.file
      object.file.size
    end
  end
end
