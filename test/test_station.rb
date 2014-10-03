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
    @station = CitibikeTrips::Station.new(@data)
  end

  def test_initialize
    # Some regular fields
    assert_equal 72, @station.id
    assert_equal 'W 52 St & 11 Ave', @station.name
    assert_equal false, @station.test_station
    # Test conversion of empty string values to nil
    assert_nil @station.location
    # Test special handling of city
    assert_equal 'New York', @station.city
    # Virtual fields
    assert_equal ['W 52 St & 11 Ave'], @station.street_address_array
    assert_equal 'W 52 St & 11 Ave', @station.street_address
  end
  def test_to_json
    json = @station.to_json
    assert_kind_of String, json
    data = JSON.parse(json)
    assert_equal 72, data['id']
    assert_equal 'W 52 St & 11 Ave', data['name']
    assert_equal false, data['test_station']
    assert_nil data['location']
    assert_equal 'New York', data['city']
    assert_equal ['W 52 St & 11 Ave'], data['street_address_array']
    assert_equal 'W 52 St & 11 Ave', data['street_address']
  end
end
