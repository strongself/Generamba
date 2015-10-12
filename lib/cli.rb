require 'thor'
require 'xcodeproj'

module Generamba::CLI
	class Application < Thor

	  desc 'gen MODULE_NAME', 'Creates a new VIPER module with a given name'
	  method_option :description, :aliases => '-d', :desc => 'Provides a full description to the module'
	  method_option :file_path, :aliases => '-p', :desc => 'Provides a file path, where the module directory will be created'
	  method_option :group_path, :aliases => '-g', :desc => 'Provides a group path to the module group in the Xcode file'
	  method_option :xcodeproj_path, :aliases => '-x', :desc => 'Provides a path to .xcodeproj file'
	  def gen(moduleName)
      	moduleDescription = options[:description] ? options[:description] : "Sample Description"
      	moduleFilePath = options[:file_path] ? options[:file_path] : File.basename(Dir.getwd)
      	moduleGroupPath = options[:group_path] ? options[:group_path] : moduleName
      	moduleXcodeprojPath = ""
      	if options[:xcodeproj_path]
      		moduleXcodeprojPath = options[:xcodeproj_path]
      	else
      		projectFiles = Dir['*.xcodeproj']
      		count = projectFiles.count
      		if count == 0
      			puts('No .xcodeproj files found in a given folder. Try generamba in another folder.')
      		elsif count == 1
      			moduleXcodeprojPath = File.absolute_path(projectFiles[0])
			elsif count > 1
				puts('Multiple .xcodeproj files found in a given folder. You should choose one manually.')
      		end
      	end

      	generator = Generamba::ModuleGenerator.new()
      	generator.generateModule(moduleName, moduleDescription, moduleFilePath, moduleGroupPath, moduleXcodeprojPath)
		end

		desc 'setup', 'Creates a Rambafile with a config for a given project'
		def setup
			name = ask('What is your name?')
			puts(name)
		end
	end
end