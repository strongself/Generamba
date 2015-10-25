require 'fileutils'

module Generamba
	class ModuleGenerator

		def initialize
		end

		def generate_module(template, name, description)
			template_path = File.dirname(__FILE__) + "/default_templates/" + template
			template_spec = Dir[template_path + "/" + template + '.rambaspec'][0]

			configuration = ProjectConfiguration
			file_content_generator = FileContentGenerator.new
			processor = ViperModuleProcessor.new()
			project = Xcodeproj::Project.open(configuration.xcodeproj_path)
			code_module = CodeModule.new(template_spec)

			# Получаем таргет проекта
			project_target = nil
			targets = project.targets
			targets.each { |target|
				if target.name == configuration.project_target
					project_target = target
				end
			}

			module_dir_path = configuration.project_file_path + name
			module_group_path = configuration.project_group_path + name
			FileUtils.mkdir_p module_dir_path

			code_module.files.each { |file|
				file_name = configuration.prefix + name + File.basename(file['name'])
				file_group = File.dirname(file['name'])
				file_content = file_content_generator.create_element(template_path + '/' + file['path'], name, description, file_name, configuration)
				file_path = module_dir_path + "/" + file_group + "/" + file_name
				FileUtils.mkdir_p File.dirname(file_path)
				File.open(file_path, "w+") {|f|
					f.write(file_content)
				}

				module_group = processor.retreive_or_create_pbxgroup(project, module_group_path + "/" + file_group)
				xcode_file = module_group.new_file(File.absolute_path(file_path))
				if File.extname(file_name) == '.m'
					project_target.add_file_references([xcode_file])
				end

			}

			project.save
		end
	end
end