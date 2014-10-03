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
  def test_each
    count = 0
    @stations.each{|id, station| count += 1}
    assert_equal 332, count
  end
  def test_includes_enumerable
    assert @stations.any?{|id, station| id == 72 && station.name == 'W 52 St & 11 Ave'}
    assert @stations.all?{|id, station| station.name}
  end
  def test_to_json
    json = @stations.to_json
    assert_kind_of String, json
    data = JSON.parse(json)
    assert_equal 332, data.length
    assert_equal 'W 52 St & 11 Ave', data['72']['name']
    assert_equal 20, data['3002']['available_docks']
  end
end
