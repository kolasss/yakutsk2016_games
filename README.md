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


## nginx config 
```
server {
    listen 80 default_server;
    server_name backend.yakutsk2016.com;

    # Tell Nginx and Passenger where your app's 'public' directory is
    root /home/kolas/www/data_yakutsk2016/current/public;

    # Turn on Passenger
    passenger_enabled on;
    passenger_ruby /home/kolas/.rbenv/versions/2.3.1/bin/ruby;

    client_max_body_size 10M;
}
```

## logrotate config
```
/home/kolas/www/data_yakutsk2016/shared/log/production.log
{
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    copytruncate
    su kolas kolas
}
```
