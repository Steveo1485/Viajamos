source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.1.0'

gem 'angularjs-rails'
gem 'angularjs-rails-resource', '~> 1.1.1'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'delayed_job_active_record'
gem 'devise'
gem "font-awesome-rails"
gem 'gon'
gem 'haml'
gem 'haml-rails'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem "koala", "~> 1.10.0rc"
gem 'mysql2'
gem 'omniauth-facebook'
gem 'pundit'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn', '~> 4.8.3'

gem 'sdoc', '~> 0.4.0',          group: :doc

group :production, :staging do
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'spring'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers', require: false
end

group :development, :test do
  gem 'database_cleaner'
  gem 'did_you_mean'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0.0'
end