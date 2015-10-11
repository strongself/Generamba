require 'thor'

module Generamba::CLI
	class Application < Thor
      desc 'gen MODULE_NAME, MODULE_DESCRIPTION, MODULE_FILE_PATH, MODULE_GROUP_PATH, XCODEPROJ_PATH', 'Creates a VIPER module with a given properties'
      def gen(moduleName, moduleDescription, moduleFilePath, moduleGroupPath, xcodeprojPath)
      	generator = Generamba::ModuleGenerator.new()
      	generator.generateModule(moduleName, moduleDescription, moduleFilePath, moduleGroupPath, xcodeprojPath)
      end
	end
end