class Api::V1::DocumentsController < ApplicationController

  def upload
    authorization_information = verify_authorization_headers_present
    unless authorization_information
      return nil
    end
    result = ::Cartafact::Entities::Operations::Documents::Upload.new.call(params_hash)

    if result.success?
      render :json => {status: "success", reference_id: result.value![:reference_id]}
    else
      render :json => {status: "failure", errors: result.failure[:message]}
    end
  end

  # query for documents. Returns an array. Option to return document blobs defaults to false
  def where
    authorization_information = verify_authorization_headers_present
    unless authorization_information
      return nil
    end
    result = ::Cartafact::Entities::Operations::Documents::Where.new.call(params_hash)
    if result.success?
      render :json => {status: "success", documents: result.value![:documents], message: ''}
    else
      render :json => {status: "failure", documents: result.failure[:documents], message: ''}
    end
  end

  # query for documents. Returns an array. Option to return document blobs defaults to true
  def find
    result = ::Cartafact::Entities::Operations::Documents::Find.new.call(params_hash)
    if result.success?
      render :json => {status: "success", document: result.value![:document], message: ''}
    else
      render :json => {status: "failure", document: result.failure[:document], message: ''}
    end
  end

  # finds document & renders it to client 
  def show
    authorization_information = verify_authorization_headers_present
    unless authorization_information
      return nil
    end
  end

  private

  def params_hash
    params.permit!.to_h
  end

  def verify_authorization_headers_present
    # req_identity = "X-RequestingIdentity"
    # req_identity_signature = "X-RequestingIdentitySignature"
    req_identity = request.headers["HTTP_X_REQUESTINGIDENTITY"]
    req_identity_signature = request.headers["HTTP_X_REQUESTINGIDENTITYSIGNATURE"]
    validation = Cartafact::Operations::ValidateResourceIdentitySignature.call(
      {
        requesting_identity_header: req_identity,
        requesting_identity_signature_header: req_identity_signature
      }
    )
    unless validation.success?
      render status: 403, json: {error: "not_authorized"}
      return nil
    end
    validation.value!
  end
end
