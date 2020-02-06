module Cartafact
  module Transactions
    class Dependencies
      include Dry::Transaction

      step :initialize
      step :assign
      step :load

      private

      def initialize(input)
        container = Class.new(Dry::System::Container)
        Success(container)
      end

      def assign(input)
        Kernel.send(:remove_const, 'DocStorage') if defined? DocStorage
        Kernel.const_set("DocStorage", input)
        Success()
      end

      def load(input)
        # binding.pry
      end


      # def configure
      #   result = initialize_container
      #   raise ResourceRegistry::Error::ContainerCreateError, result.errors if result.failure?

      #   assign_registry_constant(result.value!)
      #   load_container_dependencies

      #   result = Registries::Transactions::RegistryConfiguration.new.call(yield[:application])
      #   if result.failure?
      #     raise ResourceRegistry::Error::InitializationFileError, result.failure.messages
      #   end

      #   @config = result.value!
      #   @resource_registry_config = yield[:resource_registry]
      # end

      # def initialize_container
      #   Registries::Operations::CreateContainer.new.call
      # end

      # def assign_registry_constant(container)
      #   ResourceRegistry.send(:remove_const, 'RegistryInject') if defined? RegistryInject
      #   ResourceRegistry.const_set(:RegistryInject, container.injector)

      #   Kernel.send(:remove_const, 'Registry') if defined? Registry
      #   Kernel.const_set("Registry", container)
      # end

      # def load_container_dependencies
      #   dependencies_path = Pathname.new(__dir__).join('system', 'dependencies')
      #   Registries::Transactions::LoadContainerDependencies.new.call(dependencies_path)
      # end
    end
  end
end
