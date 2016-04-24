require 'liquid'

module Generamba

  # Responsible for creating Generamba configs
  class RambafileGenerator

    # Creates a Rambafile using the provided properties hashmap
    # @param properties Rambafile properties
    #
    # @return void
    def self.create_rambafile(properties)
      file_source = IO.read(File.dirname(__FILE__) + '/Rambafile.liquid')

      template = Liquid::Template.parse(file_source)
      output = template.render(properties).gsub!(/[\n]{3,}/, "\n\n");

      File.open(RAMBAFILE_NAME, 'w+') {|f|
        f.write(output)
      }
    end
  end
end