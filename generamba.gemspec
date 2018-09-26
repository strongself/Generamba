# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generamba/version'

Gem::Specification.new do |spec|
  spec.name          = 'generamba'
  spec.version       = Generamba::VERSION
  spec.authors       = ['Egor Tolstoy', 'Andrey Zarembo', 'Beniamin Sarkisyan', 'Aleksandr Sychev']
  spec.email         = 'rambler.ios@rambler-co.ru'

  spec.summary       = 'Advanced code generator for Xcode projects with a nice and flexible template system.'
  spec.description   = 'Generamba is a powerful and easy-to-use Xcode code generator. It provides a project-based configuration, flexible templates system, the ability to generate code and tests simultaneously.'
  spec.homepage      = 'https://github.com/rambler-digital-solutions/Generamba'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['generamba']
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2'

  spec.add_runtime_dependency 'thor', '0.19.1'
  spec.add_runtime_dependency 'xcodeproj', '1.5.6'
  spec.add_runtime_dependency 'liquid', '4.0.0'
  spec.add_runtime_dependency 'git', '1.2.9.1'
  spec.add_runtime_dependency 'cocoapods-core', '1.4.0'
  spec.add_runtime_dependency 'terminal-table', '1.4.5'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'fakefs', '~> 0.6.1'
  # ActiveSupport dependency is not used by dashramba; instead some other dependency
  # requires it. We lock it to 4.2.7 so as to avoid using 5.0, which is
  # not compatible with older versions of Ruby.
  spec.add_development_dependency 'activesupport', '~> 4.2', '>= 4.2.7'
end
