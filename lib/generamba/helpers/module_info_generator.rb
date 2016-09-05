module Generamba

  class ModuleInfoGenerator
    attr_reader :scope

    def initialize(code_module)
      module_info = {
          'name' => code_module.name,
          'description' => code_module.description,
          'project_name' => code_module.project_name,
          'product_module_name' => code_module.product_module_name,
          'project_targets' => code_module.project_targets,
          'test_targets' => code_module.test_targets
      }

      developer = {
          'name' => code_module.author,
          'company' => code_module.company
      }

      @scope = {
          'year' => code_module.year,
          'date' => Time.now.strftime('%d/%m/%Y'),
          'developer' => developer,
          'module_info' => module_info,
          'prefix' => code_module.prefix,
          'custom_parameters' => code_module.custom_parameters
      }
    end

  end

end