source 'https://rubygems.org'

ruby '>= 2.6.4', '< 3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11.3'
gem 'bootstrap-sass', '~> 3.3.5'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'


# Use Unicorn as the app server
# gem 'unicorn'

gem 'themoviedb'

# Window support
gem 'tzinfo'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

group :test do
  gem 'cucumber-rails', require: false
  gem 'cucumber-rails-training-wheels'
end 

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'capybara'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'database_cleaner'
  gem 'sqlite3', '~> 1.3.13'
  gem 'factory_bot_rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :production do
  gem 'pg', '~> 0.21'
  gem 'rails_12factor'
end
