# frozen_string_literal: true

module Documents

  # Create a new document resource.
  class Create
    send(:include, Dry::Monads[:result, :do])

    def call(params)
      values    = validate(params)
      document  = persist(values)

      Success(document)
    end

    private

    def validate(params)
      Documents::CreateContract.new.call(params)
    end

    def persist(values)
      persisted_document = Documents::Persist.new.call(values.to_h)
    end

    # def serialize_persist_result(persist_result)
    #   ::DocumentSerializer.new(persist_result.value!).serializable_hash[:data][:attributes]
    # end


  end
end

