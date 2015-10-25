require 'fileutils'

require 'generamba/helpers/template_helper.rb'
require 'generamba/helpers/xcodeproj_helper.rb'

module Generamba

	# Responsible for creating the whole code module using information from the CLI
	class ModuleGenerator

		def initialize
		end

		def generate_module(template_name, name, description)
			# Setting up CodeModule and ModuleTemplate objects.
			# TODO: Move it to the CLI infrastructure
			code_module = CodeModule.new(name, description)
			template = ModuleTemplate.new(template_name)

			# Setting up Xcode objects
			project = XcodeprojHelper.obtain_project(ProjectConfiguration.xcodeproj_path)
			project_target = XcodeprojHelper.obtain_target(ProjectConfiguration.project_target,
																										 project)

			# Configuring the whole module file path
			module_dir_path = Pathname.new(ProjectConfiguration.project_group_path)
														.join(name)
			FileUtils.mkdir_p module_dir_path

			# Configuring the whole module Xcode group path
			module_group_path = Pathname.new(ProjectConfiguration.project_group_path)
															.join(name)

			template.files.each do |file|
				# The target file's name consists of three parameters: project prefix, module name and template file name.
				# E.g. RDS + Authorization + Presenter.h = RDSAuthorizationPresenter.h
				file_name = ProjectConfiguration.prefix + name + File.basename(file['name'])
				file_group = File.dirname(file['name'])

				# Generating the content of the code file
				file_content = ContentGenerator.create_file_content(file,
																														code_module,
																														template)
				file_path = module_dir_path
												.join(file_group)
												.join(file_name)

				# Creating the file in the filesystem
				FileUtils.mkdir_p File.dirname(file_path)
				File.open(file_path, 'w+') do |f|
					f.write(file_content)
				end

				# Creating the file in the Xcode project
				XcodeprojHelper.add_file_to_project_and_target(project,
																											 project_target,
																											 module_group_path.join(file_group),
																											 file_path)
			end

			# Saving the current changes in the Xcode project
			project.save
		end
	end
end