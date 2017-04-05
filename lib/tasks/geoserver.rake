namespace :geoserver do

  GEOSERVER_URL = 'http://geoserver:8080/geoserver/rest'
  CONTENT_TYPE  = 'Content-type: text/xml'
  CREDENTIALS   ='admin:geoserver'

  WORKSPACE     ='beetrack'
  DATASTORE     ='beetrack'

  CURL= "curl -v -u #{CREDENTIALS} -H '#{CONTENT_TYPE}'"


  desc 'Creates workspace'
  task workspace: :environment do
    %x[#{CURL} -XPOST  -d '<workspace><name>#{WORKSPACE}</name></workspace>' #{GEOSERVER_URL}/workspaces]
    raise 'cannot create workspace' unless $?.success?
  end

  desc 'Creates datastore'
  task datastore: :environment do
    %x[#{CURL} -XPOST -T config/geoserver/datastore.xml #{GEOSERVER_URL}/workspaces/#{WORKSPACE}/datastores]
    raise 'cannot create workspace' unless $?.success?
  end

  desc 'Publish layers'
  task layers: :environment do
    %x[#{CURL} -XPOST -T config/geoserver/trackings.xml #{GEOSERVER_URL}/workspaces/#{WORKSPACE}/datastores/#{DATASTORE}/featuretypes]
    raise 'cannot publish waypoints' unless $?.success?

    %x[#{CURL} -XPOST -T config/geoserver/waypoints.xml  #{GEOSERVER_URL}/workspaces/#{WORKSPACE}/datastores/#{DATASTORE}/featuretypes]
    raise 'cannot publish trackings' unless $?.success?
  end

  desc 'All'
  task all: [:workspace, :datastore, :layers]
end
