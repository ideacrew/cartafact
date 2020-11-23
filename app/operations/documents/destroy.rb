# frozen_string_literal: true

module Documents
  # Destroy document
  class Destroy
    include Dry::Monads[:result, :do, :try, :maybe, :list]

    def self.call(params)
      call(params)
    end

    def call(params)
      document  = yield find_document(params)
      action    = yield destroy_document(document)

      Success(action)
    end

    private

    def find_document(params)
      Documents::Find.new.call(params)
    end

    def destroy_document(document)
      Try { document.destroy! }.to_result
    end

  end
end
