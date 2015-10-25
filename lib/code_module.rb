require 'settingslogic'

module Generamba
  class CodeModule
    attr_reader :files

    def initialize(path)
      @spec = Settingslogic.new(path)
      @files = @spec['module_files']
    end
  end
end