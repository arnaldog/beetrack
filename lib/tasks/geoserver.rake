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

  desc 'Creates default style'
  task styles: :environment do
    # %x[#{CURL} -d "<style><name>vehicles</name><filename>default_style.sld</filename></style>" #{GEOSERVER_URL}/styles]
    %x[curl -v -u #{CREDENTIALS} -XPUT -H "Content-type: application/vnd.ogc.sld+xml" -d @config/geoserver/vehicles.sld #{GEOSERVER_URL}/styles/vehicles]
    raise 'cannot create workspace' unless $?.success?
  end

  desc 'Publish layers'
  task layers: :environment do
    %x[#{CURL} -XPOST -T config/geoserver/trackings.xml #{GEOSERVER_URL}/workspaces/#{WORKSPACE}/datastores/#{DATASTORE}/featuretypes]
    raise 'cannot publish waypoints' unless $?.success?
  end

  desc 'Apply style to layers'
  task layer_style: :environment do
    %x[#{CURL} -XPUT -d "<layer><defaultStyle><name>vehicles</name></defaultStyle></layer>" #{GEOSERVER_URL}/layers/beetrack:trackings]
    raise 'cannot set up style for trackings' unless $?.success?
  end 

  desc 'All'
  task all: [:workspace, :datastore, :styles, :layers, :layer_style]
end
