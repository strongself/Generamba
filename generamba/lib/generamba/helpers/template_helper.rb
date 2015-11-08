module Generamba

  # Provides a number of helper methods for manipulating Generamba template files
  class TemplateHelper

    # Returns a file path for a specific template .rambaspec file
    # @param template_name [String] The Generamba template name
    #
    # @return [Pathname]
    def self.obtain_spec(template_name)
      template_path = self.obtain_path(template_name)
      spec_path = template_path.join(template_name + '.rambaspec')

      return spec_path
    end

    # Returns a file path for a specific template folder
    # @param template_name [String] The Generamba template name
    #
    # @return [Pathname]
    def self.obtain_path(template_name)
      path = Pathname.new(Dir.getwd)
                 .join('Templates')
                 .join(template_name)

      error_description = "Cannot find #{template_name}! Add it to the Rambafile and run *generamba template install*"
      raise StandardError.new(error_description) if path.exist? == false

      return path
    end
  end
end