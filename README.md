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

## Redis console

`docker-compose run redis redis-cli -h redis`

## Postgres console

`docker-compose run db psql -h db -U postgres -d concrn_development`

## Running `rails` commands

Use the oh-so-long but temporarily necessary invocation `docker-compose
run web bundle exec`
