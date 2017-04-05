# BEETRACK GPS


# Architecture
- Postgres/PostGIS for high performance geographic data handle
- Geoserver for tile rendering (this allow render thousands of points without browser overhead)
- Ruby on Rails for api and web endpoints
- Redis as queue for process api waypoints

# Deployment
- Docker for deploy all services

 Data Model

 - Vehicle 
 - Waypoint 
 - Tracking (relation between vehicle and the last waypoint) to be shown in map

# Startup

## Building containers
- docker-compose build web
- docker-compsoe build sidekiq

## Setting up steps

Each of these steps should be performed in order.

### Setting up the database

- ./docker-wrapper web rake db:reset
- ./docker-wrapper web rake db:migrate 

### Startup all services

### Setting up layer configurations
- ./docker-wrapper web bundle exec rake geoserver:all

### Optional
Populate with points 
- ./docker-wrapper web bundle exec rake data:all


### UI.

- Choose between all waypoints or all vehicles last position using the layer switcher.


## Run All tests
 - ./docker-wrapper web bundle exec rspec



Requirements
 - Docker Installed
 - Ports 8080 and 8000 should be unused

