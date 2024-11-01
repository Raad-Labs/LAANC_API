# laanc_api_client.gemspec

Gem::Specification.new do |spec|
  spec.name          = "laanc_api_client"
  spec.version       = LaancApiClient::VERSION
  spec.authors       = ["JP Silvashy"]
  spec.email         = ["jp@raad.com"]

  spec.summary       = %q{Ruby client for FAA LAANC REST API}
  spec.description   = %q{A Ruby gem to interact with the FAA LAANC REST API for drone flight authorizations.}
  spec.homepage      = "https://github.com/yourusername/laanc_api_client"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  spec.files         = Dir["lib/**/*", "README.md", "LICENSE.txt"]
  spec.bindir        = "exe"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 1.0"
  spec.add_dependency "faraday_middleware", "~> 1.0"
  spec.add_dependency "json", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
