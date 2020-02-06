# require 'cartafact/documents/upload'
# require 'cartafact/documents/download'
require 'config/initializers/shrine'
# require 'cartafact/transactions/dependencies'
require 'cartafact/operations/require_file'
# require 'system/dependencies/registries.rb'


module Cartafact
  include Dry::Core::Constants

  def self.configure
    container = Class.new(Dry::System::Container)

    Cartafact.send(:remove_const, 'DocStorageInject') if defined? DocStorageInject
    Cartafact.const_set(:DocStorageInject, container.injector)

    Kernel.send(:remove_const, 'DocStorage') if defined? DocStorage
    Kernel.const_set("DocStorage", container)

    path = Pathname.new(__dir__).join('system', 'dependencies', 'registries.rb')
    Cartafact::Operations::RequireFile.new.call(path)
    load_dependencies
    binding.pry
  end

  def self.load_dependencies
    path = Pathname.new(__dir__).join('cartafact', 'documents', 'download.rb')
    Cartafact::Operations::RequireFile.new.call(path)
    path = Pathname.new(__dir__).join('cartafact', 'documents', 'upload.rb')
    Cartafact::Operations::RequireFile.new.call(path)
    path = Pathname.new(__dir__).join('cartafact', 'documents', 'document.rb')
    Cartafact::Operations::RequireFile.new.call(path)
  end
end
