class CreateDocumentsDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents_documents do |t|

      t.timestamps
    end
  end
end
