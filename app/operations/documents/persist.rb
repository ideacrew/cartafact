# frozen_string_literal: true

module Documents

  # Shared operation for create/update of document.
  class Persist
    send(:include, Dry::Monads[:result, :do])

    def call(params)
      values    = validate(params)
      document  = persist(values)

      Success(document)
    end

    private

    def validate(params)
      Documents::CreateContract.new.call(params.to_h)
    end

    def persist(values)
      document = Documents::DocumentModel.new(values.to_h)
      document.save! ? Success(document) : Failure(document.errors.to_h)
    end

    def map_to_model_params(params)
      model_params = params.dup
      s_params = model_params.delete(:subjects)
      subject_params = s_params.map do |subj|
        {
          subject_id: subj[:id],
          subject_type: subj[:type]
        }
      end
      model_params.merge(:subjects => subject_params)
    end
  end
end

