source 'https://rubygems.org'


gem 'rails', '4.2.6'
gem 'rails-api'

gem 'pg'
gem 'pg_search' #PostgreSQL's full text search.
gem 'annotate' # ruby model annotations

gem 'jbuilder', '~> 2.0'

# File upload
gem 'carrierwave'
gem 'mini_magick'

# Pagination
gem 'kaminari'

gem 'closure_tree' # tree structure
gem 'activerecord_json_validator'

gem "sorcery"
# gem "pundit" #authorization
gem 'jwt'

group :development, :test do
  gem 'byebug'
  gem 'spring'
end

group :development do
  # ruby deployment system
  gem "capistrano", "~> 3.4"
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-bundler', '~> 1.1.2'
end

group :production do
  gem 'rack-cors', :require => 'rack/cors'
end
