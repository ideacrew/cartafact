require "rails_helper"

describe ClientApplicationKey do
  describe "given an invalid signature" do
    subject do
      ClientApplicationKey.new(
        signing_key: "SOME KEY"
      )
    end

    let(:data) { "SOME RANDOM DATA" }
    let(:signature) { "A BOGUS SIGNATURE" }

    it "finds it invalid" do
      expect(subject.valid_signature?(data, signature)).to be_falsey
    end
  end

  describe "given a valid signature" do
    subject do
      ClientApplicationKey.new(
        signing_key: signing_key
      )
    end

    let(:signing_key) { "SOME KEY" }

    let(:data) { "SOME RANDOM DATA" }
    let(:signature) { OpenSSL::HMAC.digest("SHA256", signing_key, data) }

    it "finds it valid" do
      expect(subject.valid_signature?(data, signature)).to be_truthy
    end
  end

end