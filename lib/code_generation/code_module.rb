require 'settingslogic'

module Generamba
  class CodeModule
    attr_reader :files, :name

    def initialize(path)
      @spec = Settingslogic.new(path)
      @files = @spec['module_files']
      @name = @spec.name
    end
  end
end