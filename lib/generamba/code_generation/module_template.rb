require 'generamba/helpers/template_helper.rb'

module Generamba

  # Represents a single Generamba module template
  class ModuleTemplate
    attr_reader :template_name, :template_path, :code_files, :test_files, :dependencies

    def initialize(name)
      spec_path = TemplateHelper.obtain_spec(name)
      spec = YAML.load_file(spec_path)
      
      @code_files = spec[TEMPLATE_CODE_FILES_KEY]
      @test_files = spec[TEMPLATE_TEST_FILES_KEY]
      @template_name = spec[TEMPLATE_NAME_KEY]
      @template_path = TemplateHelper.obtain_path(name)
      @dependencies = spec[TEMPLATE_DEPENDENCIES_KEY]
    end
  end
end