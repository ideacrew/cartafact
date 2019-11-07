module Entities
  class Document
    extend Dry::Initializer

    option :tags, type: Array, default: []
    option :size, type: String

    option :key
    option :owner_organization_name,  optional: true
    option :owner_account_name,       optional: true
    option :options,        type: Dry::Types['coercible.array'].of(ResourceRegistry::Entities::OptionConstructor), optional: true, default: -> { [] }
  end
end
