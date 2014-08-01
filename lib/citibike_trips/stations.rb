class CitibikeTrips::Stations
  STATIONS_URL = 'https://www.citibikenyc.com/stations/json'
  
  attr_reader :timestamp, :stations
  
  def initialize
    agent = Mechanize.new
    page = agent.get(STATIONS_URL)
    data = JSON.parse(page.body)
    @timestamp = Time.parse(data['executionTime'])
    @stations = {}
    data['stationBeanList'].each do |s|
      station =  CitibikeTrips::Station.new(s)
      @stations[station.id] = station
    end
  end
  
  def [](id)
    @stations[id]
  end
end
