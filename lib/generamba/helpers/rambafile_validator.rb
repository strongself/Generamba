module Generamba
  # Provides methods for validating Rambafile contents
  class RambafileValidator
    # Method validates Rambafile contents
    # @param path [String] The path to a Rambafile
    #
    # @return [Void]
    def validate(path)
      file_contents = open(path).read
      preferences = file_contents.empty? ? {} : YAML.load(file_contents).to_hash

      mandatory_fields = [COMPANY_KEY,
                          PROJECT_NAME_KEY,
                          XCODEPROJ_PATH_KEY]

      mandatory_fields.each do |field|
        unless preferences[field]
          puts "Rambafile is broken! *#{field}* field cannot be empty, because it is mandatory. Either add it manually, or run *generamba setup*.".red
          exit
        end
      end

      project_failure_fields = all_project_failure_fields(preferences)
      test_failure_fields = all_test_failure_fields(preferences)
      failure_fields = project_failure_fields + test_failure_fields

      if failure_fields.count > 0
        puts "Rambafile is broken! Cannot find any of #{failure_fields} fields, one of them is mandatory. Either add it manually, or run *generamba setup*.".red
        exit
      end

      unless preferences[TEMPLATES_KEY]
        puts "You can't run *generamba gen* without any templates installed. Add their declarations to a Rambafile and run *generamba template install*.".red
        exit
      end
    end

    private

    # Method which return all project failure fields
    # @param preferences [Hash] Converted Rambafile
    #
    # @return [Array]
    def all_project_failure_fields(preferences)
      file_path = preferences[PROJECT_FILE_PATH_KEY]
      group_path = preferences[PROJECT_GROUP_PATH_KEY]

      return [] if !file_path || !group_path

      all_nil_mandatory_fields_for_target_type('project', preferences)
    end

    # Method which return all test failure fields
    # @param preferences [Hash] Converted Rambafile
    #
    # @return [Array]
    def all_test_failure_fields(preferences)
      target = preferences[TEST_TARGET_KEY]
      targets = preferences[TEST_TARGETS_KEY]
      file_path = preferences[TEST_FILE_PATH_KEY]
      group_path = preferences[TEST_GROUP_PATH_KEY]

      has_test_fields = target || targets || file_path || group_path

      return [] unless has_test_fields

      all_nil_mandatory_fields_for_target_type('test', preferences)
    end

    # Method which return all failure fields for target_type
    # @param target_type [String] "project" or "test"
    # @param preferences [Hash] Converted Rambafile
    #
    # @return [Array]
    def all_nil_mandatory_fields_for_target_type(target_type, preferences)
      target_type = target_type.upcase

      target_const_value = Generamba.const_get(target_type + '_TARGET_KEY')
      targets_const_value = Generamba.const_get(target_type + '_TARGETS_KEY')

      target = preferences[target_const_value]
      targets = preferences[targets_const_value]

      fields = []

      if !target && (!targets || (targets && targets.count == 0))
        fields.push(target_const_value)
      end

      file_path_const_value = Generamba.const_get(target_type + '_FILE_PATH_KEY')

      unless preferences[file_path_const_value]
        fields.push(file_path_const_value)
      end

      group_path_const_value = Generamba.const_get(target_type + '_GROUP_PATH_KEY')

      unless preferences[group_path_const_value]
        fields.push(group_path_const_value)
      end

      fields
    end
  end
end
