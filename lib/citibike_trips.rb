require "citibike_trips/version"
require 'citibike_trips/station'
require 'citibike_trips/stations'
require 'citibike_trips/trip'
require 'citibike_trips/trips'
require 'highline/import'
require 'mechanize'

module CitibikeTrips
  LOGIN_URL = 'https://www.citibikenyc.com/login'
  def self.login(page)
    page.form_with(action: LOGIN_URL) do |form|
      form.subscriberUsername = ask('Citi Bike username: ')
      form.subscriberPassword = ask('Citi Bike password: ') {|q| q.echo = false}
      form.click_button(form.button_with(name: 'login_submit'))
    end
  end
end
