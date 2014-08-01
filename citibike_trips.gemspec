# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'citibike_trips/version'

Gem::Specification.new do |spec|
  spec.name          = "citibike_trips"
  spec.version       = CitibikeTrips::VERSION
  spec.authors       = ["Jason Heiss"]
  spec.email         = ["jheiss@aput.net"]
  spec.summary       = %q{Fetches your Citi Bike trip data}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/jheiss/citibike_trips"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'mocha'
  spec.add_dependency 'highline'
  spec.add_dependency 'mechanize'
end
