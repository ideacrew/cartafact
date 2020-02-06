class Api::V1::DocumentsController < ApplicationController

  def upload
    result = ::Cartafact::Entities::Operations::Documents::Upload.new.call(params_hash)

    if result.success?
      render :json => {status: "success", reference_id: ''}
    else
      render :json => {status: "failure", errors: ''}
    end
  end

  # query for documents. Returns an array. Option to return document blobs defaults to false
  def where
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
  end

  private

  def params_hash
    params.permit!.to_h
  end
end
