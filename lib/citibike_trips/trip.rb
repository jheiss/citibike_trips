class CitibikeTrips::Trip
  attr_reader :id, :start_station, :end_station, :start_timestamp, :end_timestamp
  
  def initialize(id, start_station, end_station, start_timestamp, end_timestmap)
    @id = id
    stations = CitibikeTrips::Stations.new
    @start_station = stations[start_station.to_i]
    @end_station = stations[end_station.to_i]
    @start_timestamp = Time.at(start_timestamp.to_i)
    @end_timestamp = Time.at(end_timestmap.to_i)
  end
end
