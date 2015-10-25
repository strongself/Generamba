require 'thor'
require 'xcodeproj'
require 'liquid'
require 'tilt'

module Generamba::CLI
	class Application < Thor

	  desc 'gen MODULE_NAME', 'Creates a new VIPER module with a given name'
	  method_option :description, :aliases => '-d', :desc => 'Provides a full description to the module'
	  method_option :file_path, :aliases => '-p', :desc => 'Provides a file path, where the module directory will be created'
	  method_option :group_path, :aliases => '-g', :desc => 'Provides a group path to the module group in the Xcode file'
	  method_option :xcodeproj_path, :aliases => '-x', :desc => 'Provides a path to .xcodeproj file'
	  def gen(moduleName)
        doesRambafileExist = Dir['Rambafile'].count > 0

        if (doesRambafileExist == false)
          puts('Rambafile not found! Run `generamba setup` in the working directory instead!')
          return;
        end

        config = Generamba::ProjectConfiguration;

      	moduleDescription = options[:description] ? options[:description] : "Sample Description"
      	moduleFilePath = config.project_file_path
      	moduleGroupPath = config.project_group_path
      	moduleXcodeprojPath = config.xcodeproj_path
      	if options[:xcodeproj_path]
      		moduleXcodeprojPath = options[:xcodeproj_path]
        end

      	generator = Generamba::ModuleGenerator.new()
      	generator.generateModule(moduleName, moduleDescription, moduleFilePath, moduleGroupPath, moduleXcodeprojPath)
		end

		desc 'setup', 'Creates a Rambafile with a config for a given project'
		def setup
			properties = {}

			properties['author_name'] = ask('The author name which will be used in the headers:')
			properties['author_company'] = ask('The company name which will be used in the headers')
			properties['prefix']  = ask('The project prefix (if any):')

      xcodePath = ''
      projectFiles = Dir['*.xcodeproj']
      count = projectFiles.count
      if count == 1
        isRightPath = yes?('The path ro a .xcodeproj file of the project is ' + projectFiles[0] + '. Do you want to use it?')
        if (isRightPath)
          xcodePath = File.absolute_path(projectFiles[0])
        else
          xcodePath = ask('The path to a .xcodeproj file of the project:')
        end
      else
        xcodePath = ask('The path to a .xcodeproj file of the project:')
      end
			properties['xcodeproj_path'] = xcodePath
			project = Xcodeproj::Project.open(xcodePath)

			targetsPrompt = ""
			project.targets.each_with_index { |element, i| targetsPrompt += ("#{i}. #{element.name}" + "\n") }

			projectTargetIndex = ask("Select the appropriate target for adding your modules (print the index):\n" + targetsPrompt)
			projectTarget = project.targets[projectTargetIndex.to_i]

			testTargetIndex = ask("Select the appropriate target for adding your tests (print the index):\n" + targetsPrompt)
			testTarget = project.targets[testTargetIndex.to_i]

			projectGroupPath = ask('The default group path for creating new modules:')
			projectFilePath = ask('The default file path for creating new modules:')

			testGroupPath = ask('The default group path for creating tests:')
			testFilePath = ask('The default file path for creating tests:')

			template = Tilt.new(File.dirname(__FILE__) + '/Rambafile.liquid')
			properties['project_target'] = projectTarget.name
			properties['project_file_path'] = projectFilePath
			properties['project_group_path'] = projectGroupPath
			properties['test_target'] = testTarget.name
			properties['test_file_path'] = testFilePath
			properties['test_group_path'] = testGroupPath
			output = template.render(properties)

			File.open('Rambafile', "w+") {|f|
				f.write(output)
			}
		end
	end
end