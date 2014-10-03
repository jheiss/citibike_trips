require 'json'

class CitibikeTrips::Station
  attr_reader :id, :name,
    :available_docks, :total_docks, :available_bikes,
    :latitude, :longitude, :location, :altitude,
    :street_address, :street_address_array, :city, :postal_code,
    :status_value, :status_key,
    :test_station, :last_communication_time, :landmark
  
  def initialize(data)
    data.each do |k,v|
      if v == ''
        data[k] = nil
      end
    end
    @id = data['id']
    @name = data['stationName']
    @available_docks = data['availableDocks']
    @total_docks = data['totalDocks']
    @available_bikes = data['availableBikes']
    @latitude = data['latitude']
    @longitude = data['longitude']
    @location = data['location']
    @altitude = data['altitude']
    @street_address_array = [data['stAddress1']]
    if data['stAddress2']
      @street_address_array << data['stAddress2']
    end
    @street_address = @street_address_array.join(', ')
    @city = data['city'] || 'New York'
    @postal_code = data['postalCode']
    @status_value = data['statusValue']
    @status_key = data['statusKey']
    @test_station = data['testStation']
    @last_communication_time = data['lastCommunicationTime']
    @landmark = data['landMark']
  end
  def to_json(*a)
    Hash[instance_variables.collect{|i| [i[1..-1], instance_variable_get(i)]}].to_json(*a)
  end
end
