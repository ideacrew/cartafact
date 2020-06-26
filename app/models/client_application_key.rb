class ClientApplicationKey
  include Mongoid::Document
  include Mongoid::Timestamps

  field :application_name, type: String
  field :signing_key, type: String

  index(application_name: 1)

  validates_length_of :application_name, allow_blank: false
  validates_length_of :signing_key, allow_blank: false, min: 6, max: 256

  def self.locate_keys(application_name)
     ClientApplicationKey.where(application_name: application_name)
  end

  def valid_signature?(data, signature)
    signature == OpenSSL::HMAC.digest("SHA256", self.signing_key, data)
  end
end