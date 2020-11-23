# frozen_string_literal: true

      module Documents
        # Validates the provided parameters required to find
        # and authorize viewing a document resource.
        class FindContract < ApplicationContract
          params do
            required(:authorized_subjects).array(:hash) do
              required(:subject_id).value(:string)
              required(:subject_type).value(:string)
            end

            required(:authorized_identity).hash do
              required(:user_id).value(:string)
              required(:system).value(:string)
            end
            required(:id).value(:string)
          end
        end
      end

