# frozen_string_literal: true

# Dublin Core metadata elements
class DocumentResource < Dry::Struct

    # @!attribute [r] identifier
    # An unambiguous reference to the resource
    #
    # Recommended practice is to identify the resource by means of a string conforming to an
    # identification system. Examples include International Standard Book Number (ISBN), Digital
    # Object Identifier (DOI), and Uniform Resource Name (URN).
    #
    # Persistent identifiers should be provided as HTTP URIs.
    # @return [String]
    attribute :identifier,      ::Types::String.meta(omittable: false)

    # @!attribute [r] title
    # A name given to the resource.
    # @return [String]
    attribute :title,           Types::String.meta(omittable: true)

    # @!attribute [r] creator
    # Entity responsible for making the resource - person, organization or service
    # @return [String]
    attribute :creator,         Types::String.meta(omittable: false)

    # @!attribute [r] publisher
    # Entity responsible for making the resource available - person, organization or service
    # @return [String]
    attribute :publisher,       Types::String.meta(omittable: false)

    # @!attribute [r] type
    # The nature or genre of the resource
    #
    # Conforms to {http://dublincore.org/documents/2000/07/11/dcmi-type-vocabulary DCMI Type Vocabulary}
    # @return [String]
    attribute :type,            Types::DcmiType.meta(omittable: false)

    # @!attribute [r] format
    # The file format, physical medium, or dimensions of the resource.
    # Conforms to {http://www.iana.org/assignments/media-types/media-types.xhtml IANA mime types}
    # @example
    #   "application/pdf"
    # @return [String]
    attribute :format,          Types::String.meta(omittable: false)

    # @!attribute [r] source
    # A related resource from which the described resource is derived
    #
    # Best practice is to identify the related resource by means of a URI or a string conforming to a
    # formal identification system.
    # @return [String]
    attribute :source,          Types::String.meta(omittable: false)

    # @!attribute [r] language
    # Locale reference. Conforms to ISO 639
    # @return [Symbol]
    attribute :language,        Types::Symbol.meta(omittable: false)

    # @!attribute [r] date_submitted
    # Date of submission of the resource.
    # @return [DateTime]
    attribute :date_submitted,  Types::DateTime.meta(omittable: false)

    # @!attribute [r] subject
    # A topic of the resource. Typically, the subject will be represented using keywords, key phrases,
    # or classification codes. Recommended best practice is to use a controlled vocabulary.
    #
    # Recommended practice is to refer to the subject with a URI. If this is not possible or feasible,
    # a literal value that identifies the subject may be provided. Both should preferably refer to a
    # subject in a controlled vocabulary.
    # @example
    #   Mapped to ConsumerRole::VLP_DOCUMENT_KINDS
    # @return [Array<String>]
    attribute :subject,         Types::Array.of(Types::String).meta(omittable: true)

    # @!attribute [r] description
    # May include but is not limited to: an abstract, a table of contents, a graphical representation,
    # or a free-text account of the resource
    # @return [String]
    attribute :description,     Types::String.meta(omittable: true)

    # @!attribute [r] contributor
    # Entity responsible for making contributions to the resource - person, organization or service
    #
    # Recommended practice is to identify the creator with a URI. If this is not possible or feasible,
    # a literal value that identifies the creator may be provided.
    # @return [String]
    attribute :contributor,     Types::String.meta(omittable: true)

    # @!attribute [r] coverage
    # Spatial (e.g. "District of Columbia") or temporal (e.g. "Open Enrollment 2016") topic of the resource
    # Spatial topic and spatial applicability may be a named place or a location specified by its
    # geographic coordinates. Temporal topic may be a named period, date, or date range. A jurisdiction
    # may be a named administrative entity or a geographic place to which the resource applies.
    #
    # Recommended practice is to use a controlled vocabulary such as the
    # {https://www.getty.edu/research/tools/vocabularies/tgn Getty Thesaurus of Geographic
    # Names (TGN)}. Where appropriate, named places or time periods may be used in preference to numeric
    # identifiers such as sets of coordinates or date ranges.
    # @return [Mixed]
    attribute :coverage,        Types::String.meta(omittable: true)

    # @!attribute [r] date
    # A point or period of time associated with an event in the lifecycle of the resource.
    # @return [Date]
    attribute :date,            Types::Date.meta(omittable: true)

    # @!attribute [r] created
    # Date of creation of the resource.
    # @return [DateTime]
    attribute :created,         Types::DateTime.meta(omittable: true)

    # @!attribute [r] date_accepted
    # Date of acceptance of the resource.
    # @return [DateTime]
    attribute :date_accepted,   Types::DateTime.meta(omittable: true)

    # @!attribute [r] valid
    # Date (often a range) of validity of a resource
    #
    # Recommended practice is to describe the date, date/time, or period of time as recommended
    # for the property Date, of which this is a subproperty.
    # @return [DateTime]
    attribute :valid,           Types::DateTime.meta(omittable: true)

    # @!attribute [r] relation
    # A related resource - a string conforming to a formal identification system
    # @return [Array<String>]
    attribute :relation,        Types::Array.of(Types::String).meta(omittable: true)


    # @!attribute [r] rights
    # Information about rights held in and over the resource.
    #
    # Typically, rights information includes a statement about various property rights associated
    # with the resource, including intellectual property rights. Recommended practice is to refer to a
    # rights statement with a URI. If this is not possible or feasible, a literal value (name, label,
    # or short text) may be provided.
    #
    # Range includes: {https://www.dublincore.org/specifications/dublin-core/dcmi-terms/#http://purl.org/dc/terms/RightsStatement RightsStatement}
    # @return [Array<String>]
    attribute :rights,          Types::Array.of(Types::String).meta(omittable: true)

    # @!attribute [r] access_rights
    # Information about who may access the resource or an indication of its security status.
    #
    # Access Rights may include information regarding access or restrictions based on privacy,
    # security, or other policies.
    # @return [Array<String>]
    attribute :access_rights,   Types::Array.of(Types::String).meta(omittable: true)


    # @!attribute [r] extent
    # The size or duration of the resource.
    #
    # Recommended practice is to specify the file size in megabytes and duration in ISO 8601 format.
    # @return [Mixed]
    attribute :extent,          Types::Any.meta(omittable: true)
end
