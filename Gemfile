source 'https://rubygems.org'

gem 'sqlite3'

gem 'rails', '~> 4'
gem 'sass'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'paperclip', '~> 4.2'

gem 'bower-rails'
gem 'angular-rails-templates'

group :production, :staging do
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem "foreman"
group :production, :staging do
  gem "rails_12factor"
  gem "rails_stdout_logging"
  gem "rails_serve_static_assets"
end

group :test, :development do
  gem "rspec"
  gem "rspec-rails", "~> 2.0"
  gem "factory_girl_rails", "~> 4.0"
  gem "capybara"
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem 'teaspoon'
  gem 'phantomjs'
end

group :doc do
  gem 'sdoc', require: false
end

