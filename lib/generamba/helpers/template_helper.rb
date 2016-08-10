module Generamba
  # Provides a number of helper methods for manipulating Generamba template files
  class TemplateHelper
    # Returns a file path for a specific template .rambaspec file
    # @param template_name [String] The Generamba template name
    #
    # @return [Pathname]
    def self.obtain_spec(template_name)
      template_path = obtain_path(template_name)
      spec_path = template_path.join(template_name + RAMBASPEC_EXTENSION)

      spec_path
    end

    # Returns a file path for a specific template folder
    # @param template_name [String] The Generamba template name
    #
    # @return [Pathname]
    def self.obtain_path(template_name)
      path = Pathname.new(Dir.getwd)
                     .join(TEMPLATES_FOLDER)
                     .join(template_name)

      error_description = "Cannot find template named #{template_name}! Add it to the Rambafile and run *generamba template install*".red
      raise StandardError, error_description unless path.exist?

      path
    end
  end
end
