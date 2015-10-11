module Generamba
	class ModuleGenerator
def initialize
end

		def generateModule(name, description)

			fileGenerator = FileGenerator.new
			viperModule = ViperModule.new(name, description, "/", "MyModule")
			files = Array.new

			# This will be laoded from template
			elementTypes = ["Assembly", "ViewController", "Presenter", "Interactor", "Router"]
			elementTypes.each { |element| 
				fileName = name + element
				fileContent = fileGenerator.createElement(element)

				file = ModuleFile.new(fileName, fileContent)
				files.push(file)
			}
			return files
		end
	end
end