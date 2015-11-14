require 'fileutils'

require 'generamba/helpers/xcodeproj_helper.rb'

module Generamba

	# Responsible for creating the whole code module using information from the CLI
	class ModuleGenerator

		def generate_module(template_name, name, description)
			# Setting up CodeModule and ModuleTemplate objects.
			# TODO: Move it to the CLI infrastructure
			code_module = CodeModule.new(name, description)
			template = ModuleTemplate.new(template_name)

			# Setting up Xcode objects
			project = XcodeprojHelper.obtain_project(ProjectConfiguration.xcodeproj_path)
			project_target = XcodeprojHelper.obtain_target(ProjectConfiguration.project_target,
																										 project)
			test_target = XcodeprojHelper.obtain_target(ProjectConfiguration.test_target,
																									project)

			# Configuring file paths
			module_dir_path = Pathname.new(ProjectConfiguration.project_file_path)
														.join(name)
			test_dir_path = Pathname.new(ProjectConfiguration.test_file_path)
													.join(name)
			FileUtils.mkdir_p module_dir_path
			FileUtils.mkdir_p test_dir_path

			# Configuring group paths
			module_group_path = Pathname.new(ProjectConfiguration.project_group_path)
															.join(name)
			test_group_path = Pathname.new(ProjectConfiguration.test_group_path)
														.join(name)

			# Creating code files
			puts('Creating code files...')
			process_files(template.code_files,
										name,
									 	code_module,
									 	template,
										project,
									 	project_target,
										module_group_path,
										module_dir_path)

			# Creating test files
			puts('Creating test files...')
			process_files(template.test_files,
										name,
										code_module,
										template,
										project,
										test_target,
										test_group_path,
										test_dir_path)

			# Saving the current changes in the Xcode project
			project.save
			puts("Module #{name} successfully created!")
		end

		def process_files(files, name, code_module, template, project, target, group_path, dir_path)
			XcodeprojHelper.clear_group(project, group_path)
			files.each do |file|
				# The target file's name consists of three parameters: project prefix, module name and template file name.
				# E.g. RDS + Authorization + Presenter.h = RDSAuthorizationPresenter.h
				file_basename = name + File.basename(file['name'])
				prefix = ProjectConfiguration.prefix
				file_name = prefix ? prefix + file_basename : file_basename

				file_group = File.dirname(file['name'])

				# Generating the content of the code file
				file_content = ContentGenerator.create_file_content(file,
																														code_module,
																														template)
				file_path = dir_path
												.join(file_group)
												.join(file_name)

				# Creating the file in the filesystem
				FileUtils.mkdir_p File.dirname(file_path)
				File.open(file_path, 'w+') do |f|
					f.write(file_content)
				end

				# Creating the file in the Xcode project
				XcodeprojHelper.add_file_to_project_and_target(project,
																											 target,
																											 group_path.join(file_group),
																											 file_path)
			end
		end
	end
end