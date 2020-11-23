# frozen_string_literal: true

module Documents

  # Create a new document resource.
  class Find
    send(:include, Dry::Monads[:result, :do, :try])

    def call(params)
      values    = validate(params)
      document  = find(values)

      Success(document)
    end

    private

    def validate(params)
      return Failure(error: "expected :id key: #{params.to_h}") unless params[:id]
      return Success(params.merge!(id: BSON::ObjectId.from_string(params.to_h[:id])))
    end

    def find(values)
      Try { Documents::DocumentModel.where( "_id" => values.to_h[:id]).first }.to_result
    end

  end
end

