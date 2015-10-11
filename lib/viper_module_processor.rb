module Generamba
	# This class allows to do a lot of cool stuff with a given ViperModule model object
	class ViperModuleProcessor

		def initialize(viperModule, project)
			@viperModule = viperModule
			@project = project
		end

		# Finds or creates a group in a xcodeproj file with given path
		def retreive_or_create_pbxgroup
			groupPath = @viperModule.groupPath
			groupNames = group_names_from_group_path(groupPath)

			finalGroup = @project

			groupNames.each do |groupName|
				nextGroup = finalGroup[groupName]
				if (nextGroup == nil)
					nextGroup = finalGroup.new_group(groupName)
				end

				finalGroup = nextGroup
			end

			# Temporary
			@project.save

			return finalGroup
		end

		# Returns an array with filepaths to all of the module parts
		def retreive_file_paths

		end

		private

		# Returns the destination PBXGroup from a given groupPath
		def group_names_from_group_path(groupPath)
			groups = groupPath.split("/")
			return groups
		end
	end
end