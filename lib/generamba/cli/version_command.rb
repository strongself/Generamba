require 'thor'
require 'generamba/version.rb'

module Generamba::CLI
  class Application < Thor
    include Generamba

    desc 'version', 'Prints out Generamba current version'
    def version
      options = {}
      options['Version'] = Generamba::VERSION.green
      options['Release date'] = Generamba::RELEASE_DATE.green
      options['Change notes'] = Generamba::RELEASE_LINK.green

      values = []

      options.each do |title, value|
        values.push("#{title}: #{value}")
      end

      output = values.join("\n")
      puts(output)
    end
  end
end