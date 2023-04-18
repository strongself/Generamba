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
      mandatory_fields = [COMPANY_KEY]

      mandatory_fields.each do |field|
        unless code_module.instance_variable_get("@#{field}")
          puts "Module is broken! *#{field}* field cannot be empty, because it is mandatory.".red
          exit
        end
      end
    end
  end
end