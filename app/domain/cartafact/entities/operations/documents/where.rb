# frozen_string_literal: true

require "dry/transaction/operation"

module Cartafact
  module Entities
    module Operations
      module Documents
        # Given identity and search criteria, return a list of document resources.
        class Where
          include Dry::Transaction::Operation

          def self.call(input)
            new.call(input)
          end

          def call(input)
            matching_criteria = search_params_from_entity(input.authorized_subjects)
            return Failure(:no_subjects_specified) if matching_criteria.empty?

            documents = ::Document.where("subjects" =>
              { "$elemMatch" =>
              { "$or" =>
              matching_criteria } })
            return Failure(:no_documents_found) if documents.empty?

            serialized_documents = documents.lazy.map do |doc|
              ::DocumentSerializer.new(doc).serializable_hash[:data][:attributes]
            end

            Success(serialized_documents)
          end

          def search_params_from_entity(authorized_subjects)
            authorized_subjects.map do |a_subj|
              {
                "subject_id" => a_subj.id,
                "subject_type" => a_subj.type
              }
            end
          end
        end
      end
    end
  end
end
