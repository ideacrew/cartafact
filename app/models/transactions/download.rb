module Transactions
  class Download
    include Dry::Transaction

    step :load
    step :validate
    step :serve

    private

    def load(input)
      bucket = parse_text(input[:bucket])
      key = parse_text(input[:key])
      Success({bucket: bucket, key: key})
    end

    def validate(input)
      if input[:bucket].blank? || input[:key].blank?
        return Failure({message: "Bucket/Key should not be blank"})
      end
      Success({bucket: input[:bucket], key: input[:key]})
    end

    def serve(input)
      begin
        object = resource.bucket(input[:bucket]).object(input[:key])
        encoded_result = Base64.encode64(object.get.body.read)
        Success({message: "Successfully retrieved documents.", result: encoded_result})
      rescue Exception => e
        Failure({message: e.message})
      end
    end

    def resource
      @resource ||= Aws::S3::Resource.new(client: client)
    end

    def client
      @client ||= Aws::S3::Client.new(stub_responses: stub?)
    end

    def stub?
      Rails.env.development? || Rails.env.test?
    end

    def parse_text(val)
      return nil if val.nil?
      val.to_s.squish!
    end
  end
end
