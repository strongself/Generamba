module Generamba
  # Provides methods for validating module
  class ModuleValidator

    # Method validates module
    # @param code_module [CodeModule] The instance of CodeModule
    #
    # @return [Void]
    def validate(code_module)
      mandatory_fields = [COMPANY_KEY,
                          PROJECT_PREFIX_KEY,
                          PROJECT_NAME_KEY,
                          XCODEPROJ_PATH_KEY,
                          PROJECT_TARGETS_KEY,
                          'module_file_path',
                          'module_group_path']

      mandatory_fields.each do |field|
        unless code_module.instance_variable_get("@#{field}")
          puts "Module is broken! *#{field}* field cannot be empty, because it is mandatory.".red
          exit
        end
      end
    end

  end
end