require 'thor'
require 'fileutils'

require 'generamba/helpers/xcodeproj_helper.rb'

module Generamba

	# Responsible for creating the whole code module using information from the CLI
	class ModuleGenerator < Thor
		no_commands {
			def generate_module(name, code_module, template)
				# Setting up Xcode objects
				project = XcodeprojHelper.obtain_project(code_module.xcodeproj_path)

				# Configuring file paths
				FileUtils.mkdir_p code_module.module_file_path

				if code_module.test_file_path != nil
					FileUtils.mkdir_p code_module.test_file_path
				end

				replace_exists_module = yes?("#{name} module already exists. Replace? (yes/no)")
				return if replace_exists_module == false

				# Creating code files
				puts('Creating code files...')
				process_files_if_needed(template.code_files,
																name,
																code_module,
																template,
																project,
																code_module.project_targets,
																code_module.module_group_path,
																code_module.module_file_path)

				# Creating test files
				puts('Creating test files...')
				process_files_if_needed(template.test_files,
																name,
																code_module,
																template,
																project,
																code_module.test_targets,
																code_module.test_group_path,
																code_module.test_file_path)

				# Saving the current changes in the Xcode project
				project.save
				puts("Module successfully created!\n" +
								 "Name: #{name}".green + "\n" +
								 "Module file path: #{code_module.module_file_path}".green + "\n" +
								 "Module group path: #{code_module.module_group_path}".green + "\n" +
								 "Test file path: #{code_module.test_file_path}".green + "\n" +
								 "Test group path: #{code_module.test_group_path}".green)
			end

			def process_files_if_needed(files, name, code_module, template, project, targets, group_path, dir_path)
				# It's possible that current project doesn't test targets configured, so it doesn't need to generate tests.
				# The same is for files property - a template can have only test or project files
				if targets.count == 0 || files == nil || files.count == 0 || dir_path == nil || group_path == nil
					return
				end

				XcodeprojHelper.clear_group(project, targets, group_path)
				files.each do |file|
					# The target file's name consists of three parameters: project prefix, module name and template file name.
					# E.g. RDS + Authorization + Presenter.h = RDSAuthorizationPresenter.h
					file_basename = name + File.basename(file[TEMPLATE_NAME_KEY])
					prefix = code_module.prefix
					file_name = prefix ? prefix + file_basename : file_basename

					file_group = File.dirname(file[TEMPLATE_NAME_KEY])

					# Generating the content of the code file
					file_content = ContentGenerator.create_file_content(file, code_module, template)
					file_path = dir_path.join(file_group).join(file_name)

					# Creating the file in the filesystem
					FileUtils.mkdir_p File.dirname(file_path)
					File.open(file_path, 'w+') do |f|
						f.write(file_content)
					end

					# Creating the file in the Xcode project
					XcodeprojHelper.add_file_to_project_and_targets(project, targets, group_path.join(file_group), file_path)
				end
			end
		}
	end
end