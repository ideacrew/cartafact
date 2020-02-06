module Cartafact
  module Operations
    class RequireFile

      include Dry::Transaction::Operation

      def call(path)
        Kernel.send(:load, path)
        Success(path)
      end
    end
  end
end
