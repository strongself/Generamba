module Generamba

  # Provides methods for validating Rambafile contents
  class RambafileValidator

    # Method validates Rambafile contents
    # @param path [String] The path to a Rambafile
    def validate(path)
      file_contents = open(path).read
      preferences = file_contents.empty? ? {} : YAML.load(file_contents).to_hash

      mandatory_fields = [COMPANY_KEY,
                          PROJECT_NAME_KEY,
                          XCODEPROJ_PATH_KEY,
                          PROJECT_TARGET_KEY,
                          PROJECT_FILE_PATH_KEY,
                          PROJECT_GROUP_PATH_KEY,
                          TEST_TARGET_KEY,
                          TEST_FILE_PATH_KEY,
                          TEST_GROUP_PATH_KEY,
                          TEMPLATES_KEY]

      mandatory_fields.each { |field|
        if preferences.has_key?(field) == false
          error_description = "Rambafile is broken! Cannot find #{field} field, which is mandatory. Either add it manually, or run *generamba setup*."
          raise StandardError.new(error_description)
        end
      }

      if preferences[TEMPLATES_KEY] == nil
        error_description = "You can't run *generamba gen* without any templates installed. Add their declarations to a Rambafile and run *generamba template install*."
        raise StandardError.new(error_description)
      end

    end

  end
end