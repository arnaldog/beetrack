namespace :data do


  desc 'Post fake data to api'

  task concepcion: :environment do
   %x[#{CURL} -XPOST  -d '{ "vehicle_identifier": "HB-3451",  "sent_at": "2016-06-02 20:45:00",  "latitude": "-36.8269900",  "longitude": "-73.0497700" }' http://web:8000/api/v1/gps ]
    raise 'cannot post a vehicle position' unless $?.success?
  end

  task santiago: :environment do
   %x[#{CURL} -XPOST  -d '{ "vehicle_identifier": "HB-3451",  "sent_at": "2016-06-02 20:45:00",  "latitude": "-33.447487",  "longitude": "-70.673676" }' http://web:8000/api/v1/gps ]
    raise 'cannot post a vehicle position' unless $?.success?
  end

  desc 'All'
  task all: [:concepcion, :santiago]
end


