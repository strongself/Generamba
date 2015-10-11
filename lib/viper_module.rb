module Generamba
	# A model class for the whole VIPER Module
	class ViperModule

		attr_reader :name, :description, :files, :filePath, :groupPath

		def initialize(name, description, filePath, groupPath)
			@name = name
			@description = description
			@filePath = filePath
			@groupPath = groupPath
			@files = Array.new
		end
	end

	class ModuleFile
		attr_reader :name, :content, :path

		def initialize(name, content)
			@name = name
			@content = content
		end
	end
end