#!/bin/bash

docker volume create --name beetrack-postgres
docker volume create --name beetrack-redis

docker-compose run --user "$(id -u):$(id -g)" beetrack rake db:reset
docker-compose run --user "$(id -u):$(id -g)" beetrack rake db:migrate

docker-compose up


## Create a job
# docker-­compose run --­­user "$(id -­u):$(id -­g)" beetrack rails g job tracker