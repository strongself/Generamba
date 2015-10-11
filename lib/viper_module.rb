module Generamba
	# A model class for the whole VIPER Module
	class ViperModule

		attr_reader :name, :description, :files, :groupPath

		def initialize(name, description, groupPath, files)
			@name = name
			@description = description
			@groupPath = groupPath
			@files = files
		end
	end

	class ModuleFile
		attr_reader :name, :content, :path

		def initialize(name, content, path)
			@name = name
			@content = content
			@path = path
		end
	end
end