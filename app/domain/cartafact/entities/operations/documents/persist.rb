module Cartafact
  module Entities
    module Operations
      module Documents
        class Persist

          include Dry::Transaction::Operation

          def call(input)
            document = ::Document.new(map_to_model_params(input.to_h))
            if document.save
              Success(document)
            else
              Failure(document.errors.to_h)
            end
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
            model_params.merge({:subjects => subject_params})
          end
        end
      end
    end
  end
end

