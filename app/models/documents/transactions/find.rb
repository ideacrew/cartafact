module Documents
  module Transactions
    class Find
      include Dry::Transaction

      step :load
      step :validate, with: 'documents.validations.symbolize_keys'
      step :serialize
      step :serve

      step :symbolize_keys, with: 'resource_registry.serializers.symbolize_keys'
      step :validate,       with: 'resource_registry.enterprises.validate'
      step :create,         with: 'resource_registry.enterprises.create'

      private

      def load(input)
        key = parse_text(input[:key])
        Success({key: key})
      end

      def validate(input) # contract
        if input[:bucket].blank? || input[:key].blank?
          return Failure({message: "Bucket/Key should not be blank"})
        end
        Success({bucket: input[:bucket], key: input[:key]})
      end

      def serialize
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
end

