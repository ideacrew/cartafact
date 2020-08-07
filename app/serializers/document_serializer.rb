# frozen_string_literal: true

class DocumentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :creator, :identifier, :description, :language, :format, :source, :date, :creator

  attribute :document_type, &:document_type
  attribute :subjects do |object|
    object.subjects.map do |subj|
      {
        id: subj.subject_id,
        type: subj.subject_type
      }
    end
  end

  attribute :version do |_object|
    nil
  end

  attribute :id do |object|
    object.id.to_s
  end

  attribute :extension do |object|
    object.file&.extension
  end

  attribute :size do |object|
    object.file&.size
  end
end
