require 'fileutils'

require 'generamba/helpers/xcodeproj_helper.rb'
require 'generamba/helpers/module_info_generator.rb'

module Generamba

	# Responsible for creating the whole code module using information from the CLI
	class ModuleGenerator

		def generate_module(name, code_module, template)
			# Setting up Xcode objects
			project = XcodeprojHelper.obtain_project(code_module.xcodeproj_path)

			# Configuring file paths
			FileUtils.mkdir_p code_module.project_file_path if code_module.project_file_path
			FileUtils.mkdir_p code_module.test_file_path if code_module.test_file_path

			# Creating code files
			if code_module.project_targets && code_module.project_group_path && code_module.project_file_path
				puts('Creating code files...')
				process_files_if_needed(template.code_files,
																code_module,
																template,
																project,
																code_module.project_targets,
																code_module.project_group_path,
																code_module.project_file_path)
			end

			# Creating test files
			if code_module.test_targets && code_module.test_group_path && code_module.test_file_path
				puts('Creating test files...')
				process_files_if_needed(template.test_files,
																code_module,
																template,
																project,
																code_module.test_targets,
																code_module.test_group_path,
																code_module.test_file_path)
			end

			# Saving the current changes in the Xcode project
			project.save

			puts 'Module successfully created!'
			puts "Name: #{name}".green
			puts "Project file path: #{code_module.project_file_path}".green if code_module.project_file_path
			puts "Project group path: #{code_module.project_group_path}".green if code_module.project_group_path
			puts "Test file path: #{code_module.test_file_path}".green if code_module.test_file_path
			puts "Test group path: #{code_module.test_group_path}".green if code_module.test_group_path
		end

		def process_files_if_needed(files, code_module, template, project, targets, group_path, dir_path)
			# It's possible that current project doesn't test targets configured, so it doesn't need to generate tests.
			# The same is for files property - a template can have only test or project files
			if targets.count == 0 || files == nil || files.count == 0 || dir_path == nil || group_path == nil
				return
			end

			XcodeprojHelper.clear_group(project, targets, group_path)
			files.each do |file|
				unless file[TEMPLATE_FILE_PATH_KEY]
					directory_name = file[TEMPLATE_NAME_KEY].gsub(/^\/|\/$/, '')
					file_group = dir_path.join(directory_name)

					FileUtils.mkdir_p file_group
					XcodeprojHelper.add_group_to_project(project, group_path, dir_path, directory_name)

					next
				end

				file_group = File.dirname(file[TEMPLATE_NAME_KEY])
				file_group = nil if file_group == '.'

				module_info = ModuleInfoGenerator.new(code_module)

				# Generating the content of the code file and it's name
				file_name, file_content = ContentGenerator.create_file(file, module_info.scope, template)
				file_path = dir_path
				file_path = file_path.join(file_group) if file_group
				file_path = file_path.join(file_name) if file_name

				# Creating the file in the filesystem
				FileUtils.mkdir_p File.dirname(file_path)
				File.open(file_path, 'w+') do |f|
					f.write(file_content)
				end

				file_is_resource = file[TEMPLATE_FILE_IS_RESOURCE_KEY]

				# Creating the file in the Xcode project
				XcodeprojHelper.add_file_to_project_and_targets(project,
																												targets,
																												group_path,
																												dir_path,
																												file_group,
																												file_name,
																												file_is_resource)
			end
		end
	end
end