require 'liquid'
require 'tilt'

module Generamba

  # Responsible for creating Generamba configs
  class RambafileGenerator

    # Creates a Rambafile using the provided properties hashmap
    # @param properties Rambafile properties
    #
    # @return void
    def self.create_rambafile(properties)
      template = Tilt.new(File.dirname(__FILE__) + '/Rambafile.liquid')
      output = template.render(properties)

      File.open(RAMBAFILE_NAME, 'w+') {|f|
        f.write(output)
      }
    end
  end
end