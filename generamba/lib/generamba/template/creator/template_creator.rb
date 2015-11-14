module Generamba

  # Responsible for generating new .rambaspec files
  class TemplateCreator

    # Generates and saves to filesystem a new .rambaspec file
    # @param properties [Hash] User-inputted template properties
    #
    # @return [Void]
    def create_template(properties)
      template = Tilt.new(File.dirname(__FILE__) + '/template.rambaspec.liquid')
      output = template.render(properties)

      template_name = properties[TEMPLATE_NAME_KEY] + RAMBASPEC_EXTENSION

      File.open(template_name, 'w+') {|f|
        f.write(output)
      }
    end

  end
end