module Generamba
  # Provides methods for prepare parameters for displaying in table.
  class GenCommandTableParametersFormatter
    require 'json'

    # This method prepared parameter for displaying
    def self.prepare_parameters_for_displaying(code_module, template_name)
      params = {}

      params['Targets'] = code_module.project_targets.join(',')
      params['Module path'] = code_module.module_file_path

      if code_module.module_file_path != code_module.module_group_path
        params['Module group path'] = code_module.module_group_path
      end

      params['Test targets'] = code_module.test_targets.join(',') if code_module.test_targets
      params['Test file path'] = code_module.test_file_path if code_module.test_file_path

      if code_module.test_file_path != code_module.test_group_path
        params['Test group path'] = code_module.test_group_path
      end

      params['Template'] = template_name

      if code_module.custom_parameters
        params['Custom parameters'] = code_module.custom_parameters.to_json
      end

      params
    end
  end
end
