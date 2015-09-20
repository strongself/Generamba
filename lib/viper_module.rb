module Generamba
	# A model class for the whole VIPER Module
	class ViperModule

		attr_reader :name, :description, :filePath, :groupPath

		def initialize(name, description, filePath, groupPath)
			@name = name
			@description = description
			@filePath = filePath
			@groupPath = groupPath
		end
	end
end