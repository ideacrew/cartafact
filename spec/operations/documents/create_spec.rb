require 'rails_helper'

RSpec.describe Documents::Create do
  let(:document_attrs)  { FactoryBot.attributes_for(:documents_document_model, subjects: [{ subject_id: 'abc', subject_type: 'consumer' }]) }
  let(:content)         { Rack::Test::UploadedFile.new(tempfile, "application/pdf") }
  let(:document_json)   { { document: JSON.dump(document_attrs) } }

  let(:tempfile) do
    tf = Tempfile.new('test.pdf')
    tf.write("DATA GOES HERE")
    tf.rewind
    tf
  end
  context "with valid params" do

    it "should add a new document to the data store" do
      result = subject.call(document_attrs)

      expect(subject.success?).to be_truthy
      expect(subject.value!.to_h).to eq document_attrs
    end

  end


end