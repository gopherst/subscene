lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subscene/version'

Gem::Specification.new do |gem|
  gem.name          = "subscene"
  gem.version       = Subscene::VERSION
  gem.authors       = ["Javier Saldana"]
  gem.email         = ["javier@tractical.com"]
  gem.description   = %q{Ruby API Client for Subscene.com}
  gem.summary       = %q{Subscene.com API Client}
  gem.homepage      = "https://github.com/jassa/subscene"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "faraday",  "~> 0.8.6"
  gem.add_dependency "nokogiri", "~> 1.5.6"
  gem.add_development_dependency "rspec", "~> 2.13.0"
end
