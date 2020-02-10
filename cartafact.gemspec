# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cartafact"
  spec.version       = "1.0"
  spec.authors       = ["Dan Thomas"]
  spec.email         = ["dan@ideacrew.com"]

  spec.summary       = "cartafact"
  spec.description   = "cartafact"
  spec.homepage      = "https://github.com/dchbx/cartafact.git"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.5.0'

  spec.add_dependency 'dry-monads',               '~> 1.2'
  spec.add_dependency 'dry-system',               '~> 0.12'
  spec.add_dependency 'dry-equalizer',            '~> 0.2'
  spec.add_dependency 'dry-matcher',              '~> 0.7'
  spec.add_dependency 'dry-validation',           '~> 1.2'
  spec.add_dependency 'dry-core',                 '~> 0.4'
  spec.add_dependency 'dry-struct',               '~> 1.0'
  spec.add_dependency 'dry-types',                '~> 1.0'
  spec.add_dependency 'dry-inflector',            '~> 0.1'
  spec.add_dependency 'dry-container',            '~> 0.7'
  spec.add_dependency 'dry-auto_inject',          '~> 0.6'
  # spec.add_dependency 'dry-configurable',         '~> 0.8'
  spec.add_dependency 'dry-transaction',          '~> 0.13'
  spec.add_dependency 'dry-initializer',          '~> 3.0'
  spec.add_dependency 'deep_merge',               '~> 1.2.1'


  spec.add_dependency 'ox',                       '~> 2.0'
  spec.add_dependency 'bootsnap',                 '~> 1.0'
  spec.add_dependency 'mime-types'
  spec.add_dependency 'rails',                    '~> 5.2.3'
  spec.add_dependency 'shrine-mongoid',           '~> 1.0'
  # spec.add_dependency 'aws-sdk-s3',               '~> 1.14'

  spec.add_development_dependency "bundler",      "~> 1.0"
  spec.add_development_dependency 'rake',         '~> 12.0'
  spec.add_development_dependency 'rspec',        '~> 3.0'
  spec.add_development_dependency 'rspec-rails',  '~> 3.0'
  spec.add_development_dependency 'mongoid',      '~> 7.0'
  spec.add_development_dependency "simplecov" #,  '~> 1.0'
  spec.add_development_dependency "database_cleaner", '~> 1.7'
  spec.add_development_dependency "timecop",          '~> 0.9'
  spec.add_development_dependency 'pry-byebug'
end