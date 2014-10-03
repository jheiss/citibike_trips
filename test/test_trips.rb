require 'test/unit'
require 'mocha/test_unit'
require 'citibike_trips'

class TripsTests < Test::Unit::TestCase
  def setup
    agent = Mechanize.new
    uri1 = 'https://www.citibikenyc.com/member/trips'
    uri2 = 'https://www.citibikenyc.com/member/trips/2'
    uri15 = 'https://www.citibikenyc.com/member/trips/15'
    trips1 = File.read("#{File.dirname(__FILE__)}/samples/trips1.html")
    trips2 = File.read("#{File.dirname(__FILE__)}/samples/trips2.html")
    # Note trips2.html was modified to have trips15 as the next page
    trips15 = File.read("#{File.dirname(__FILE__)}/samples/trips15.html")
    # I just fiddled with the args here until it worked.  Ugly.
    page1 = Mechanize::Page.new(URI.parse(uri1), nil, trips1, nil, agent)
    page2 = Mechanize::Page.new(URI.parse(uri2), nil, trips2, nil, agent)
    page15 = Mechanize::Page.new(URI.parse(uri15), nil, trips15, nil, agent)
    Mechanize.any_instance.stubs(:get).with(uri1).returns(page1)
    Mechanize.any_instance.stubs(:get).with(uri2).returns(page2)
    Mechanize.any_instance.stubs(:get).with(uri15).returns(page15)
    
    page = Mechanize::Page.new
    Mechanize.any_instance.stubs(:get).with(CitibikeTrips::Stations::STATIONS_URL).returns(page)
    json = File.read("#{File.dirname(__FILE__)}/samples/stations.json")
    page.stubs(:body).returns(json)
    
    @trips = CitibikeTrips::Trips.new
  end

  def test_initialize
    # 26+20+4
    assert_equal 50, @trips.trips.length
    @trips.trips.each do |t|
      assert_kind_of CitibikeTrips::Trip, t
    end
    assert_equal 'trip-13150976', @trips.trips.first.id
    assert_equal Time.at(1369869537), @trips.trips.last.start_timestamp
    assert_equal 'Broadway & W 58 St', @trips.trips.last.start_station.name
  end
  def test_index_access
    assert_equal 'trip-13150976', @trips[0].id
    assert_equal 'Broadway & W 58 St', @trips[-1].start_station.name
  end
  def test_each
    count = 0
    @trips.each{|trip| count += 1}
    assert_equal 50, count
  end
  def test_includes_enumerable
    assert @trips.any?{|trip| trip.id == 'trip-13150976'}
    assert @trips.all?{|trip| trip.id}
  end
  def test_to_json
    json = @trips.to_json
    assert_kind_of String, json
    data = JSON.parse(json)
    assert_equal 50, data.length
    assert_equal 'trip-13150976', data[0]['id']
    assert_equal 'Broadway & W 58 St', data[-1]['start_station']['name']
  end
end
