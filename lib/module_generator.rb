require 'fileutils'

module Generamba
	class ModuleGenerator

		def initialize
		end

		def generate_module(template, name, description)
			configuration = ProjectConfiguration
			file_content_generator = FileContentGenerator.new
			processor = ViperModuleProcessor.new()
			project = Xcodeproj::Project.open(configuration.xcodeproj_path)
			code_module = CodeModule.new("viper_module/viper_module.rambaspec")

			module_dir_path = configuration.project_file_path + name
			module_group_path = configuration.project_group_path + name
			FileUtils.mkdir_p module_dir_path

			code_module.files.each { |file|
				file_name = name + File.basename(file['name'])
				file_group = File.dirname(file['name'])
				file_content = file_content_generator.createElement(code_module.name + '/' + file['path'])
				file_path = module_dir_path + "/" + file_group + "/" + file_name
				FileUtils.mkdir_p File.dirname(file_path)
				File.open(file_path, "w+") {|f|
					f.write(file_content)
				}

				module_group = processor.retreive_or_create_pbxgroup(project, module_group_path)
				module_group.new_file(File.absolute_path(file_path))
			}

			project.save
		end
	end
end