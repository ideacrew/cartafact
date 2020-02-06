# frozen_string_literal: true
module Cartafact
  module Documents
    module Validations
      CreateContract = Cartafact::Validations::ApplicationContract.build do

        params do
          required(:authorized_subjects).array(:hash) do
            required(:id).value(:string)
            required(:type).value(:string)
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
  end
end

# options = {authorized_identity: {user_id: 'abc', system: 'enroll_dc'}, authorized_subjects: [{id: 'abc', type: 'consumer'}], path: "/var/folders/qy/6j5wvm053fx1pzrk3511bd300000gn/T/RackMultipart20200130-46197-sq1zvk.pdf", document_type: 'vlp_doc'}
# Cartafact::Documents::Upload.new.call(options)