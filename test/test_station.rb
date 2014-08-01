require 'test/unit'
require 'citibike_trips'

class StationTests < Test::Unit::TestCase
  def setup
    @data = {
      "id"=>72,
      "stationName"=>"W 52 St & 11 Ave",
      "availableDocks"=>35,
      "totalDocks"=>37,
      "latitude"=>40.76727216,
      "longitude"=>-73.99392888,
      "statusValue"=>"In Service",
      "statusKey"=>1,
      "availableBikes"=>1,
      "stAddress1"=>"W 52 St & 11 Ave",
      "stAddress2"=>"",
      "city"=>"",
      "postalCode"=>"",
      "location"=>"",
      "altitude"=>"",
      "testStation"=>false,
      "lastCommunicationTime"=>nil,
      "landMark"=>""}
  end

  def test_initialize
    station = CitibikeTrips::Station.new(@data)
    # Some regular fields
    assert_equal 72, station.id
    assert_equal 'W 52 St & 11 Ave', station.name
    assert_equal false, station.test_station
    # Test conversion of empty string values to nil
    assert_nil station.location
    # Test special handling of city
    assert_equal 'New York', station.city
    # Virtual fields
    assert_equal ['W 52 St & 11 Ave'], station.street_address_array
    assert_equal 'W 52 St & 11 Ave', station.street_address
  end
end
