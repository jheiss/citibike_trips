require 'test/unit'
require 'mocha/test_unit'
require 'citibike_trips'

class StationsTests < Test::Unit::TestCase
  def setup
    page = Mechanize::Page.new
    Mechanize.any_instance.stubs(:get).with(CitibikeTrips::Stations::STATIONS_URL).returns(page)
    json = File.read("#{File.dirname(__FILE__)}/samples/stations.json")
    page.stubs(:body).returns(json)
    @stations = CitibikeTrips::Stations.new
  end
  def test_initialize
    assert_equal 332, @stations.stations.length
    @stations.stations.each do |k,v|
      assert_kind_of CitibikeTrips::Station, v
    end
    assert_equal 'W 52 St & 11 Ave', @stations.stations[72].name
    assert_equal 20, @stations.stations[3002].available_docks
  end
  def test_square_brackets
    assert_equal 'W 52 St & 11 Ave', @stations[72].name
    assert_equal 20, @stations[3002].available_docks
  end
end
