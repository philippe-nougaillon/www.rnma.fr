source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4'
# Use PG as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rails-erd'

  gem 'guard'
  gem 'guard-minitest'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  gem "minitest-reporters"
end

# Bulma
gem 'bulma-rails', '~> 0.9.0'
gem 'bulma-extensions-rails', '~> 6.2.7'
gem 'bulma_form_builder'

# Auth
gem 'devise'

# Active Storage
gem 'active_storage-postgresql'

# TAGS
gem 'acts-as-taggable-on', '~> 7.0'

# Ruby finite-state-machine-inspired API for modeling workflow 
gem 'workflow'
gem 'workflow-activerecord'

# Pagination
# gem 'will_paginate', '~> 3.1.0'
# gem 'will_paginate-bulma'
gem 'kaminari'


# Friendly ID
gem 'friendly_id', '~> 5.4.0'

# XLSX sheet
gem 'spreadsheet'
gem 'yaml_db'

gem 'page_title_helper'

# Audited (formerly acts_as_audited) is an ORM extension that logs all changes to your Rails models.
gem 'audited', '~> 4.9'

# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'

# vCardigan is a ruby library for building and parsing vCards that supports both v3.0 and v4.0.
gem 'vcardigan'

# Simple gem for sorting data in HTML tables
gem 'sortable-for-rails'

gem 'valid_email2'

# Sucker Punch is a Ruby asynchronous processing library using concurrent-ruby
gem 'sucker_punch', '~> 3.0'

# pg_search builds ActiveRecord named scopes that take advantage of PostgreSQL’s full text search
gem 'pg_search'

gem 'meta-tags'

gem 'exception_notification'

# The best Rails forums engine ever.
gem 'thredded', '~> 1.0'
# Added to fix thredded error
gem 'html-pipeline', '~> 1.11'

# Générateur de SiteMap
gem "sitemap_generator", "~> 6.2"

gem 'gemoji'

# ORM agnostic truly Object-Oriented view helper for Rails 4, 5, and 6
gem "active_decorator", "~> 1.4"

# a Ruby memcache client.
gem 'dalli'
gem "recaptcha", "~> 5.12"

gem "mailgun-ruby", "~> 1.2"

gem "dotenv-rails", "~> 2.8"
