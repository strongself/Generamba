require 'fileutils'

require 'generamba/helpers/template_helper.rb'

module Generamba
	class ModuleGenerator

		def initialize
		end

		def generate_module(template_name, name, description)
			# Setting up template
			# TODO: We should create this model in the cli files
			code_module = CodeModule.new(name, description)

			# Setting up template variables
			template = ModuleTemplate.new(template_name)
			processor = ViperModuleProcessor.new()
			project = Xcodeproj::Project.open(ProjectConfiguration.xcodeproj_path)

			# Получаем таргет проекта
			project_target = nil
			targets = project.targets
			targets.each { |target|
				if target.name == ProjectConfiguration.project_target
					project_target = target
				end
			}

			module_dir_path = ProjectConfiguration.project_file_path + name
			module_group_path = ProjectConfiguration.project_group_path + name
			FileUtils.mkdir_p module_dir_path

			template.files.each { |file|
				file_name = ProjectConfiguration.prefix + name + File.basename(file['name'])
				file_group = File.dirname(file['name'])
				file_content = ContentGenerator.create_file_content(file, code_module, template)
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