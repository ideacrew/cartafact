require 'rails_helper'

RSpec.describe Document, :type => :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:publisher) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:format) }
  it { should validate_presence_of(:source) }
  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:document_type) }
  it { should validate_presence_of(:file_data) }
end
