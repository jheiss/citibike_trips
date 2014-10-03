require 'json'

class CitibikeTrips::Trip
  attr_reader :id, :start_station, :end_station, :start_timestamp, :end_timestamp
  
  def initialize(id, start_station, end_station, start_timestamp, end_timestamp)
    @id = id
    stations = CitibikeTrips::Stations.new
    @start_station = stations[start_station.to_i]
    @end_station = stations[end_station.to_i]
    @start_timestamp = Time.at(start_timestamp.to_i)
    @end_timestamp = Time.at(end_timestamp.to_i)
  end

  def to_json(*a)
    Hash[instance_variables.collect{|i| [i[1..-1], instance_variable_get(i)]}].to_json(*a)
  end
end
