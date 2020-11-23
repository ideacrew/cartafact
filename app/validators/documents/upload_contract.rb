# frozen_string_literal: true

module Documents
  # Validates the provided parameters required to construct
  # a document upload.
  class UploadContract < ApplicationContract
    params do
      required(:authorized_subjects).array(:hash) do
        required(:subject_id).value(:string)
        required(:subject_type).value(:string)
      end

      required(:authorized_identity).hash do
        required(:user_id).value(:string)
        required(:system).value(:string)
      end

      required(:path).value(:string)
      required(:document_type).value(:string)
      optional(:title).value(:string)
      optional(:identifier).value(:string)
      optional(:description).value(:string)
      optional(:language).value(:string)
      optional(:format).value(:string)
      optional(:date).value(:string)
      optional(:content_type).value(:string)
    end
  end
end
