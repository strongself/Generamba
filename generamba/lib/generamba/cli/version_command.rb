require 'thor'
require 'generamba/version.rb'

module Generamba::CLI
  class Application < Thor
    include Generamba

    desc 'version', 'Prints out Generamba current version'
    def version
      puts(Generamba::VERSION.green)
    end
  end
end