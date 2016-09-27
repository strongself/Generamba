module Generamba

  # Provides methods that validate .rambaspec file existance and structure
  class RambaspecValidator

    # Validates the existance of a .rambaspec file for a given template
    #
    # @param template_name [String] The name of the template
    # @param template_path [String] The local filepath to the template
    #
    # @return [Bool]
    def self.validate_spec_existance(template_name, template_path)
      local_spec_path = self.obtain_spec_path(template_name, template_path)
      File.file?(local_spec_path)
    end

    # Validates the structure of a .rambaspec file for a given template
    #
    # @param template_name [String] The name of the template
    # @param template_path [String] The local filepath to the template
    #
    # @return [Bool]
    def self.validate_spec(template_name, template_path)
      spec_path = self.obtain_spec_path(template_name, template_path)

      spec_source = IO.read(spec_path)
      spec_template = Liquid::Template.parse(spec_source)
      spec_content = spec_template.render
      spec = YAML.load(spec_content)

      is_spec_valid =
          spec[TEMPLATE_NAME_KEY] != nil &&
          spec[TEMPLATE_AUTHOR_KEY] != nil &&
          spec[TEMPLATE_VERSION_KEY] != nil &&
          spec[TEMPLATE_CODE_FILES_KEY] != nil
      return is_spec_valid
    end

    private

    # Returns a filepath for a given .rambaspec filename
    #
    # @param template_name [String] The name of the template
    # @param template_path [String] The local filepath to the template
    #
    # @return [Bool]
    def self.obtain_spec_path(template_name, template_path)
      spec_filename = template_name + RAMBASPEC_EXTENSION
      Pathname.new(template_path).join(spec_filename)
    end
  end
end