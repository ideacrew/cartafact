class Api::V1::DocumentsController < ApplicationController

  def upload
  end
  
  def download
    # alterate store key, bucket in table which has reference to parent key. (Need a data migration here)
    transaction = Transactions::Download.new.call({bucket: params[:bucket], key: params[:key]})
    if transaction.success?
      render :json => {status: "success", result: transaction.value!.values}
    else
      render :json => {status: "failure", errors: transaction.failure}
    end
  end
end
