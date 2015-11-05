require 'settingslogic'

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
      rambaspec_exist = File.file?(local_spec_path)
    end

    def self.validate_spec(template_name, template_path)
      spec_path = self.obtain_spec_path(template_name, template_path)
      spec = Settingslogic.new(spec_path)

      is_spec_valid = spec.name != nil && spec.author != nil && spec.version != nil && spec.code_files != nil
      return is_spec_valid
    end

    private

    def self.obtain_spec_path(template_name, template_path)
      spec_filename = template_name + '.rambaspec'
      full_path = Pathname.new(template_path)
                      .join(spec_filename)
    end
  end
end