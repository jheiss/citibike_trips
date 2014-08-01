require 'test/unit'
require 'citibike_trips'

class TripTests < Test::Unit::TestCase
  def test_initialize
    page = Mechanize::Page.new
    Mechanize.any_instance.stubs(:get).with(CitibikeTrips::Stations::STATIONS_URL).returns(page)
    json = File.read("#{File.dirname(__FILE__)}/samples/stations.json")
    page.stubs(:body).returns(json)
    
    trip = CitibikeTrips::Trip.new('trip-13150976', '151', '517', '1406760278', '1406761369')
    assert_equal 'trip-13150976', trip.id
    assert_kind_of CitibikeTrips::Station, trip.start_station
    assert_equal 'Cleveland Pl & Spring St', trip.start_station.name
    assert_kind_of CitibikeTrips::Station, trip.end_station
    assert_equal 'E 41 St & Madison Ave', trip.end_station.name
    assert_equal Time.at(1406760278), trip.start_timestamp
    assert_equal Time.at(1406761369), trip.end_timestamp
  end
end
