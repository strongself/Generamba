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
                          PROJECT_FILE_PATH_KEY,
                          PROJECT_GROUP_PATH_KEY,
                          TEMPLATES_KEY]

      interchangable_fields = [[PROJECT_TARGETS_KEY, PROJECT_TARGET_KEY]]

      mandatory_fields.each do |field|
        unless preferences.has_key?(field)
          error_description = "Rambafile is broken! Cannot find #{field} field, which is mandatory. Either add it manually, or run *generamba setup*.".red
          raise StandardError.new(error_description)
        end
      end

      interchangable_fields.each do |fields_array|
        has_value = false
        fields_array.each do |field|
          has_value = preferences.has_key?(field) || has_value
        end

        unless has_value
          error_description = "Rambafile is broken! Cannot find any of #{fields_array} fields, one of them is mandatory. Either add it manually, or run *generamba setup*.".red
          raise StandardError.new(error_description)
        end
      end

      unless preferences[TEMPLATES_KEY]
        error_description = "You can't run *generamba gen* without any templates installed. Add their declarations to a Rambafile and run *generamba template install*.".red
        raise StandardError.new(error_description)
      end

    end

  end
end