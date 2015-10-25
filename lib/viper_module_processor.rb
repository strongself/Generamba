module Generamba
	# This class allows to do a lot of cool stuff with a given ViperModule model object
	class ViperModuleProcessor

		def initialize()
		end

		# Finds or creates a group in a xcodeproj file with given path
		def retreive_or_create_pbxgroup(project, group_path)
			group_names = group_names_from_group_path(group_path)

			final_group = project

			group_names.each do |group_name|
				next_group = final_group[group_name]
				if (next_group == nil)
					next_group = final_group.new_group(group_name)
				end

				final_group = next_group
			end

			return final_group
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