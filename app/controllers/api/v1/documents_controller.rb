class Api::V1::DocumentsController < ApplicationController

  def upload
  end

  # query for documents. Returns an array. Option to return document blobs defaults to false
  def where
  end

  # query for documents. Returns an array. Option to return document blobs defaults to true
  def find
    result = Documents::Operations::Find.call(params[:id])

    # transaction = Transactions::Download.new.call({bucket: params[:bucket], key: params[:key]})
    # if result.success?
    #   render :json => {status: "success", result: result.value!.values}
    # else
    #   render :json => {status: "failure", errors: result.failure}
    # end
  end

  # finds document & renders it to client 
  def show
  end
end
