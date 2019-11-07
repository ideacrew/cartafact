# frozen_string_literal: true

module Documents
  module Validation
    DocumentContract = Documents::Validation::ApplicationContract.build do

      params do
        required(:key).value(:symbol)
        optional(:owner_organization_name).maybe(:string)
        optional(:owner_account_name).maybe(:string)
        optional(:options).array(:hash)
      end
    end
  end
end
