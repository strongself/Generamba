module Generamba

  # Provides a number of helper methods for manipulating Generamba template files
  class TemplateHelper

    # Returns a file path for a specific template .rambaspec file
    # @param template_name The Generamba template name
    def self.obtain_spec(template_name)
      template_path = self.obtain_path(template_name)
      spec_path = template_path.join(template_name + '.rambaspec')

      return spec_path
    end

    # Returns a file path for a specific template folder
    # @param template_name The Generamba template name
    def self.obtain_path(template_name)
      path = Pathname.new(File.dirname(__FILE__)).parent()
      path = path.join('default_templates').join(template_name)

      raise StandardError.new('No such default template! Try another name.') if path.exist? == false

      return path
    end
  end
end