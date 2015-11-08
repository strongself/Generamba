require 'generamba/helpers/template_helper.rb'
require 'settingslogic'

module Generamba

  # Represents a single Generamba module template
  class ModuleTemplate
    attr_reader :template_name, :template_path, :code_files, :test_files

    def initialize(name)
      spec_path = TemplateHelper.obtain_spec(name)
      spec = Settingslogic.new(spec_path)

      @code_files = spec[:code_files]
      @test_files = spec[:test_files]
      @template_name = spec.name
      @template_path = TemplateHelper.obtain_path(name)
    end
  end
end