# frozen_string_literal: true

module Documents
  # Validates the provided parameters required to update
  class UpdateContract < ApplicationContract
    params do
      required(:id).value(:string)
      required(:path).value(:any)
    end
  end
end
