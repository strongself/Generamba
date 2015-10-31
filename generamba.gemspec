# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generamba/version'

Gem::Specification.new do |spec|
  spec.name          = "generamba"
  spec.version       = Generamba::VERSION
  spec.authors       = ["Andrey Zarembo", "Egor Tolstoy"]
  spec.email         = ["a.zarembo@rambler-co.ru", "e.tolstoy@rambler-co.ru"]

  spec.summary       = "This generator is too brilliant to be real!"
  spec.description   = "Someday we'll describe it"
  spec.homepage      = "http://rambler.ru"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["generamba"]
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "xcodeproj"
  spec.add_dependency "liquid"
  spec.add_dependency "tilt"
  spec.add_dependency 'settingslogic'
  spec.add_dependency 'git'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
