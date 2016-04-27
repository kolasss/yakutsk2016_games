source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'pg'
gem 'pg_search' #PostgreSQL's full text search.
gem 'annotate' # ruby model annotations

gem "slim-rails"
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem "autoprefixer-rails"

# File upload
gem 'carrierwave'
gem 'mini_magick'

# Pagination
gem 'kaminari'

gem 'closure_tree' # tree structure
gem 'activerecord_json_validator'

gem "sorcery"
# gem "pundit" #authorization


## ========Убрать???
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x localizations
gem 'simple_form' # form generator
gem 'bootstrap-sass'
gem 'rails_admin' # TODO удалять или нет?
## ========Убрать???


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
