module Generamba
  # Provides methods for validating module
  class ModuleValidator

    TARGET_TYPE_PROJECT = 'project'
    TARGET_TYPE_TEST = 'test'

    # Method validates module
    # @param code_module [CodeModule] The instance of CodeModule
    #
    # @return [Void]
    def validate(code_module)
      mandatory_fields = [COMPANY_KEY,
                          # XCODEPROJ_PATH_KEY,
                          PROJECT_NAME_KEY]

      mandatory_fields.each do |field|
        unless code_module.instance_variable_get("@#{field}")
          puts "Module is broken! *#{field}* field cannot be empty, because it is mandatory.".red
          exit
        end
      end

      project_failure_fields = all_project_failure_fields(code_module)
      test_failure_fields = all_test_failure_fields(code_module)
      failure_fields = project_failure_fields + test_failure_fields

      if failure_fields.count > 0
        puts "Module is broken! *#{failure_fields}* field cannot be empty, because it is mandatory.".red
        exit
      end
    end

    private

    # Method which return all project failure fields
    # @param code_module [CodeModule] The instance of CodeModule
    #
    # @return [Array]
    def all_project_failure_fields(code_module)
      return [] if !code_module.project_targets && !code_module.project_file_path && !code_module.project_group_path

      all_nil_mandatory_fields_for_target_type(TARGET_TYPE_PROJECT, code_module)
    end

    # Method which return all test failure fields
    # @param code_module [CodeModule] The instance of CodeModule
    #
    # @return [Array]
    def all_test_failure_fields(code_module)
      return [] if !code_module.test_targets && !code_module.test_file_path && !code_module.test_group_path

      all_nil_mandatory_fields_for_target_type(TARGET_TYPE_TEST, code_module)
    end

    # Method which return all failure fields for target_type
    # @param target_type [String] "project" or "test"
    # @param code_module [CodeModule] The instance of CodeModule
    #
    # @return [Array]
    def all_nil_mandatory_fields_for_target_type(target_type, code_module)
      fields = []

      variable_name = "#{target_type}_targets"

      unless code_module.instance_variable_get("@#{variable_name}")
        target_const_value = Generamba.const_get(target_type.upcase + '_TARGET_KEY')
        targets_const_value = Generamba.const_get(target_type.upcase + '_TARGETS_KEY')
        fields.push(target_const_value)
        fields.push(targets_const_value)
      end

      variable_name = "#{target_type}_file_path"
      file_path_const_value = Generamba.const_get(target_type.upcase + '_FILE_PATH_KEY')
      fields.push(file_path_const_value) unless code_module.instance_variable_get("@#{variable_name}")

      variable_name = "#{target_type}_group_path"
      group_path_const_value = Generamba.const_get(target_type.upcase + '_GROUP_PATH_KEY')
      fields.push(group_path_const_value) unless code_module.instance_variable_get("@#{variable_name}")

      fields
    end

  end
end