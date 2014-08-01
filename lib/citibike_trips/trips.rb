class CitibikeTrips::Trips
  TRIPS_URL = 'https://www.citibikenyc.com/member/trips'
  
  attr_reader :trips
  
  def initialize
    agent = Mechanize.new
    @trips = []
    url = TRIPS_URL
    loop do
      page = agent.get(url)
      if page.uri.to_s == url
        page.search('tr.trip').each do |triprow|
          trips << CitibikeTrips::Trip.new(
            triprow.attributes['id'].value,
            triprow.attributes['data-start-station-id'].value,
            triprow.attributes['data-end-station-id'].value,
            triprow.attributes['data-start-timestamp'].value,
            triprow.attributes['data-end-timestamp'].value)
        end
        if nextpagelink = page.link_with(text: '>')
          url = nextpagelink.href
        else
          break
        end
      elsif page.uri.to_s == CitibikeTrips::LOGIN_URL
        CitibikeTrips.login(page)
      else
        raise "Got redirected to unexpected page #{page.uri.to_s}"
      end
    end
  end
end
