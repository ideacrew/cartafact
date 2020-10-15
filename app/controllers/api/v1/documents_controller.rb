# frozen_string_literal: true

module Api
  module V1
    # Controller exposing the document API.
    class DocumentsController < ApplicationController
      FILE_STREAM_SIZE = 32768

      # query for documents. Returns an array.
      def index
        authorization_information = verify_authorization_headers_present
        return nil unless authorization_information

        result = ::Cartafact::Entities::Operations::Documents::Where.call(authorization_information)
        if result.success?
          render :json => result.value!, status: :ok
        else
          render :json => [], status: :ok
        end
      end

      # finds document & renders it to client
      def show
        authorization_information = verify_authorization_headers_present
        return nil unless authorization_information

        result = ::Cartafact::Entities::Operations::Documents::Show.call(
          authorization: authorization_information,
          id: params[:id]
        )
        if result.success?
          render :json => result.value!, status: :ok
        else
          render :blank => true, status: 404
        end
      end

      def create
        authorization_information = verify_authorization_headers_present
        return nil unless authorization_information

        result = ::Cartafact::Entities::Operations::Documents::Create.call(create_params)
        if result.success?
          render :json => result.value!, status: :created
        else
          render :json => result.failure, status: "422"
        end
      end

      def update
        authorization_information = verify_authorization_headers_present
        unless authorization_information
          return nil
        end
        result = ::Cartafact::Entities::Operations::Documents::Update.call(update_params)
        if result.success?
          render :json => result.value!, status: :updated
        else
          render :json => result.failure, status: "422"
        end
      end

      def destroy
        authorization_information = verify_authorization_headers_present
        unless authorization_information
          return nil
        end
        result = ::Cartafact::Entities::Operations::Documents::Destroy.call({id: params[:id]})
        if result.success?
          render :json => result.value!, status: :destroyed
        else
          render :json => result.failure, status: "422"
        end
      end

      def update_meta_data
      end

      include ActionController::Live
      def download
        authorization_information = verify_authorization_headers_present
        return nil unless authorization_information

        result = ::Cartafact::Entities::Operations::Documents::Download.call(
          authorization: authorization_information,
          id: params[:id]
        )
        if result.success?
          document = result.value!
          stream_download(document)
        else
          render :blank => true, status: 404
        end
      end

      private

      def stream_download(document)
        disposition = ActionDispatch::Http::ContentDisposition.format(
          disposition: "attachment",
          filename: document.file.original_filename
        )
        set_headers_for_download_stream(document, disposition)
        file = document.file
        file.open do
          while (data = file.read(FILE_STREAM_SIZE))
            response.stream.write data
          end
        end
      # rubocop:disable Lint/RescueException
      rescue Exception => e
        Rails.logger.error { e }
      # rubocop:enable Lint/RescueException
      ensure
        response.stream.close
      end

      def set_headers_for_download_stream(document, disposition)
        response.headers["Last-Modified"] = document.updated_at.httpdate.to_s
        response.headers["Content-Disposition"] = disposition
        response.headers['Content-Type'] = document.download_mime_type
        response.headers["Cache-Control"] = "no-cache"
        response.headers["X-Accel-Buffering"] = "no"
      end

      def create_params
        params.require(:document)
        params.permit(:content)
        JSON.parse(params[:document]).to_h.merge(path: params[:content])
      end

      def update_params
        params.require(:document).permit(:path, :id)
      end

      def verify_authorization_headers_present
        # req_identity = "X-RequestingIdentity"
        # req_identity_signature = "X-RequestingIdentitySignature"
        req_identity = request.headers["HTTP_X_REQUESTINGIDENTITY"]
        req_identity_signature = request.headers["HTTP_X_REQUESTINGIDENTITYSIGNATURE"]
        validation = Cartafact::Operations::ValidateResourceIdentitySignature.call(
          requesting_identity_header: req_identity,
          requesting_identity_signature_header: req_identity_signature
        )
        unless validation.success?
          render status: 403, json: { error: "not_authorized" }
          return nil
        end
        validation.value!
      end
    end
  end
end
