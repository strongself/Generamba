require 'fileutils'

module Generamba
	class ModuleGenerator

		def initialize
		end

		# name - The name of the module
		# description - The description of the module
		# moduleRootDirPath - The path to the root modules directory in the filesystem
		# groupFilePath - The path to the root group of the modules in the xcode project
		# projectPath - The path to the .xcodeproj file
		def generateModule(name, description, moduleRootDirPath, groupFilePath, projectPath)
			fileContentGenerator = FileContentGenerator.new
			files = Array.new
			moduleDirPath = moduleRootDirPath + "/" + name
			# Creating a new subdirectory for files
			FileUtils.mkdir_p moduleDirPath

			# THis list should be loaded from a specific template
			elementTypes = ["Assembly.h", "Assembly.m", "ViewController.h", "ViewController.m", "Presenter.h", "Presenter.m", "Interactor.h", "Interactor.m", "Router.h", "Router.m"]

			elementTypes.each { |element| 
				fileName = name + element
				fileContent = fileContentGenerator.createElement(element)
				filePath = moduleDirPath + "/" + fileName

				file = ModuleFile.new(fileName, fileContent, File.absolute_path(filePath))
				files.push(file)

				File.open(filePath, "w+") {|f| 
					f.write(fileContent) 
				}
			}

			viperModule = ViperModule.new(name, description, groupFilePath, files)

			project = Xcodeproj::Project.open(projectPath)

			processor = ViperModuleProcessor.new(viperModule, project)
			moduleGroup = processor.retreive_or_create_pbxgroup

			viperModule.files.each { |file|
				moduleGroup.new_file(file.path)
			}
			
			project.save
		end
	end
end