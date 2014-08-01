# CitibikeTrips

Get Citi Bike data.  In particular this supports getting your personal trip data from https://www.citibikenyc.com/member/trips

## Installation

Add this line to your application's Gemfile:

    gem 'citibike_trips'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install citibike_trips

## Usage

Each trip has a unique id, start station, end station, start timestamp and end timestamp.  The stations will be an instance of CitibikeTrips::Station.

    trips = CitibikeTrips::Trips.new
    puts trips.trips.length
    puts trips.first.start_station.name
    puts trips.first.end_timestamp

    stations = CitibikeTrips::Stations.new
    puts stations.stations.length
    puts stations[72].name

## Contributing

1. Fork it ( http://github.com/<my-github-username>/citibike_trips/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
