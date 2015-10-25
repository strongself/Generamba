require 'settingslogic'

module Generamba
  class CodeModule
    attr_reader :files, :template_name, :template_path

    def initialize(path)
      @spec = Settingslogic.new(path)
      @files = @spec['module_files']
      @template_name = @spec.name
      @template_path = File.dirname(path)
    end
  end
end