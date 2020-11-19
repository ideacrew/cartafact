# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# gem 'aws-sdk' #,                  '~> 2.2.4'
gem "aws-sdk-s3" #, "~> 1.14"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap',             '>= 1.4.2', require: false

gem 'dry-matcher',          '~> 0.8'
gem 'dry-monads',           '~> 1.3'
gem 'dry-struct',           '~> 1.0'
gem 'dry-validation',       '~> 1.5'

gem 'fast_jsonapi'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder',             '~> 2.7'
gem 'jwt',                  '~> 2.2.1'
gem 'mime-types'
gem 'mongoid',              '~> 7.1.0'

# Use Puma as the app server
gem 'puma',                 '~> 4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',                '~> 6.0.2'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Settings, validation and dependency injection
gem 'resource_registry', git: 'https://github.com/ideacrew/resource_registry.git', branch: 'branch_0.3.2'

gem "shrine",               '~> 3.3'
gem 'shrine-mongoid',       '~> 1.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails',            '~> 4.0'
  gem 'shoulda-matchers',       '~> 3'
  gem 'yard' # ,                   '~> 0.9.12',  require: false
  gem 'climate_control'
  gem 'factory_bot_rails',      '~> 4.11'
  gem 'database_cleaner',       '~> 1.7'
  gem 'database_cleaner-mongoid'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen',  '~> 2.0.0'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console',            '>= 3'
  gem 'listen',                 '>= 3.0.5', '< 3.2'

  gem 'rubocop',                require: false
  gem 'rubocop-rspec'
  gem 'rubocop-git'
end
