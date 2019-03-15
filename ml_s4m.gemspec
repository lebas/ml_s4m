# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ml_s4m/version'

Gem::Specification.new do |spec|
  spec.name          = "ml_s4m"
  spec.version       = MlS4m::VERSION
  spec.authors       = ["Eduardo Alencar"]
  spec.email         = ["lebas66@gmail.com"]

  spec.summary       = %q{Search in Mercado Livre}
  spec.description   = %q{Search in Mercado Livre}
  spec.homepage      = "https://facebook.com/Solution4Mac"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8.0"
  spec.add_development_dependency "pry", "~> 0.10.1"

  spec.add_dependency "nokogiri",  "1.6.8"
end
