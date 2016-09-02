require 'generamba/helpers/template_helper.rb'

module Generamba

  # Represents a single Generamba module template
  class ModuleTemplate
    attr_reader :template_name, :template_path, :code_files, :test_files, :dependencies

    def initialize(name, options = nil)
      spec_path = TemplateHelper.obtain_spec(name)

      unless options
        spec = YAML.load_file(spec_path)
      else
        spec_source = IO.read(spec_path)
        spec_template = Liquid::Template.parse(spec_source)
        spec_content = spec_template.render(options)
        spec = YAML.load(spec_content)
      end

      @code_files = spec[TEMPLATE_CODE_FILES_KEY]
      @test_files = spec[TEMPLATE_TEST_FILES_KEY]
      @template_name = spec[TEMPLATE_NAME_KEY]
      @template_path = TemplateHelper.obtain_path(name)
      @dependencies = spec[TEMPLATE_DEPENDENCIES_KEY]
    end
  end
end