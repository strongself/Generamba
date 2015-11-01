# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generamba/version'

Gem::Specification.new do |spec|
  spec.name          = 'generamba'
  spec.version       = Generamba::VERSION
  spec.authors       = ['Egor Tolstoy', 'Andrey Zarembo']
  spec.email         = ['e.tolstoy@rambler-co.ru', 'a.zarembo@rambler-co.ru']

  spec.summary       = 'Code generator for Xcode projects, specialized in creating VIPER ,modules.'
  spec.homepage      = 'http://rambler-co.ru'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['generamba']
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'
  spec.add_dependency 'xcodeproj'
  spec.add_dependency 'liquid'
  spec.add_dependency 'tilt'
  spec.add_dependency 'settingslogic'
  spec.add_dependency 'git'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0"'
  spec.add_development_dependency 'rspec'
end
