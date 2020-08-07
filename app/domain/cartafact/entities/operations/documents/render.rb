# frozen_string_literal: true

module Cartafact
  module Entities
    module Operations
      module Documents
        class Render
          include Dry::Transaction::Operation

          def call(input)
            # documents = ::Document.all.where(:"authorized_subjects".in => input.authorized_subjects)
            # if documents.blank?
            #   return Failure({message: "No Documents found", meta_data: []})
            # end

            # if input.id.present?
            #   document = documents.where(id: input.id).first
            #   if document.present?
            #     Success({message: 'Successfully retrieved document', document: {}})
            #   else
            #     Failure({message: 'No Document found with given id', document: {}})
            #   end
            # else
            #   # pass doc meta data
            #   Success({message: 'Successfully retrieved document', documents: []})
            # end
          end
        end
      end
    end
  end
end
