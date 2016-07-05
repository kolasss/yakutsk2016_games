# README


- bin/rake db:drop db:create db:migrate db:seed
- bin/rake db:drop db:create db:schema:load RAILS_ENV=test

## Starting server

- bin/rails s


## Настроика сервера для деплоя

- установить rbenv
- Для загрузки и обработки изображений нужен imagemagick: sudo apt-get install imagemagick libmagickcore-dev
- postgresql
- nginx + passenger
- capistrano deploy
- настроить database.yml, settings.yml
- настройка ssl
https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-14-04
https://mozilla.github.io/server-side-tls/ssl-config-generator/

Не добавлять add_header Strict-Transport-Security max-age=15768000; Рэилс сам добавляет такой хедер, если стоит force_ssl=true.

- sudo nginx -s reload

## deploy

bundle exec cap production deploy
bundle exec cap staging deploy

- bin/rake db:schema:load db:seed
- passenger-config restart-app
