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
      spec_filename = template_name + '.rambaspec'
      full_path = Pathname.new(template_path)
                      .join(spec_filename)
      rambaspec_exist = File.file?(full_path)

      if rambaspec_exist == false
        error_description = "Cannot find #{spec_filename} in the specified directory. Try another path or name."
        puts(error_description)
        raise StandardError.new(error_description)
      end

      return rambaspec_exist
    end
  end
end