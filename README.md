# README


## Initial setup

1. `docker-compose up --build`
2. `docker-compose run web bundle exec rails db:create
   db:migrate`

## Editing secrets

`docker-compose run --rm -e EDITOR=vim web bundle exec rails
secrets:edit`

## Running tests

`docker-compose run -e RAILS_ENV=test web rspec`

## Running `rails` commands

Use the oh-so-long but temporarily necessary invocation `docker-compose
run web bundle exec`
