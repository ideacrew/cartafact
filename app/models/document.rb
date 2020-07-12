class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Shrine::Attachment(:file)

  ACCESS_RIGHTS = %w(public pii_restricted)

  # Dublin Core metadata elements
  field :title, type: String, default: "untitled"

  # Entity responsible for making the resource - person, organization or service
  field :creator, type: String, default: "mhc"

  # Dublin Core Meta-Data for the subjects of this document
  embeds_many :subjects, class_name: "::DocumentSubject", inverse_of: :document

  # May include but is not limited to: an abstract, a table of contents, a graphical representation, or a free-text account of the resource
  field :description, type: String

  # Entity responsible for making the resource available - person, organization or service
  field :publisher, type: String, default: "mhc"

  # Entity responsible for making contributions to the resource - person, organization or service
  field :contributor, type: String

  # A point or period of time associated with an event in the lifecycle of the resource.
  field :date, type: Date

  # Conforms to DCMI Type Vocabulary - http://dublincore.org/documents/2000/07/11/dcmi-type-vocabulary/
  field :type, type: String, default: "text"

  # Conforms to IANA mime types - http://www.iana.org/assignments/media-types/media-types.xhtml
  field :format, type: String, default: "application/octet-stream"

  # An unambiguous reference to the resource - Conforms to URI
  field :identifier, type: String

  # A related resource from which the described resource is derived
  field :source, type: String, default: "enroll_system"

  # Conforms to ISO 639
  field :language, type: String, default: "en"

  # A related resource - a string conforming to a formal identification system
  field :relation, type: String

  # Spatial (e.g. "District of Columbia") or temporal (e.g. "Open Enrollment 2016") topic of the resource
  field :coverage, type: String

  # Conforms to ACCESS_RIGHTS above
  field :rights, type: String

  field :tags, type: Array, default: []

  # field :size, type: String

  field :file_data, type: String

  field :document_type, type: String

  validates_presence_of :title, :creator, :publisher, :type, :format, :source, :language, :document_type

  index({"subjects.subject_type" => 1, "subjects.subject_id" => 1}, {name: :document_subject_search_index})
  
  def path=(input)
    self.file = File.open(input) if File.exists? input
  end
end
