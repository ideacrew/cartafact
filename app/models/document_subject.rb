# frozen_string_literal: true

class DocumentSubject
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :document

  field :subject_type, type: String
  field :subject_id, type: String

  validates_length_of :subject_type, allow_blank: false
  validates_length_of :subject_id, allow_blank: false
end
