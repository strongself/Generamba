require 'fileutils'

module Generamba
	class ModuleGenerator

		def initialize
		end

		def generateModule(name, description, modulePath)
			fileContentGenerator = FileContentGenerator.new
			files = Array.new

			# Creating a new subdirectory for files
			FileUtils.mkdir_p modulePath

			# It will be loaded from template
			elementTypes = ["Assembly.h", "Assembly.m", "ViewController.h", "ViewController.m", "Presenter.h", "Presenter.m", "Interactor.h", "Interactor.m", "Router.h", "Router.m"]

			elementTypes.each { |element| 
				fileName = name + element
				fileContent = fileContentGenerator.createElement(element)
				filePath = modulePath + "/" + fileName

				file = ModuleFile.new(fileName, fileContent, filePath)
				files.push(file)

				File.open(filePath, "w+") {|f| 
					f.write(fileContent) 
				}
			}

			viperModule = ViperModule.new(name, description, "MyModule", files)

			xcodeProjectName = "GenerambaTestProject/GenerambaTestProject.xcodeproj"
			project = Xcodeproj::Project.open(xcodeProjectName)

			processor = ViperModuleProcessor.new(viperModule, project)
			moduleGroup = processor.retreive_or_create_pbxgroup

			viperModule.files.each { |file|
				moduleGroup.new_file(file.path)
			}
			
			project.save
		end
	end
end