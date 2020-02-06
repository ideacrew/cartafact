require 'cartafact/documents/transactions/create'
require 'cartafact/documents/transactions/find'
require 'cartafact/documents/operations/transfer'
require 'cartafact/documents/operations/persist'
require 'cartafact/documents/operations/find'
require 'cartafact/types'
require 'cartafact/validations/application_contract'
require 'cartafact/documents/validations/create_contract'
require 'cartafact/documents/validations/find_contract'

DocStorage.namespace :"cartafact" do

  namespace :"documents.transactions" do
    register :"create" do
      Cartafact::Documents::Transactions::Create.new
    end

    register :"find" do
      Cartafact::Documents::Transactions::Find.new
    end
  end

  namespace :"documents.operations" do
    register :"transfer" do
      Cartafact::Documents::Operations::Transfer.new
    end

    register :"persist" do
      Cartafact::Documents::Operations::Persist.new
    end

    register :"find" do
      Cartafact::Documents::Operations::Find.new
    end
  end

  namespace :"documents.validations" do
    register :"validate_create" do
      Cartafact::Documents::Validations::CreateContract
    end

    register :"validate_find" do
      Cartafact::Documents::Validations::FindContract
    end
  end
end
