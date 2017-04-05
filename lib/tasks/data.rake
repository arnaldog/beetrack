namespace :data do


  desc 'Post data to api'

  task send: :environment do

  end
  desc 'All'
  task all: [:workspace, :datastore, :layers]
end
