require 'xcodeproj'

class Generamba::XcodeInjector
	def initialize
		@project = Xcodeproj::Project.open(File.dirname(__FILE__) + "/SynchronizationProblems.xcodeproj")
	end

	def list_files_in_group(groupName)
		group = destinationGroupFromPath(groupName, @project)
		print(group.files)
	end

	def add_file_to_group(groupName, filePath)
		group = destinationGroupFromPath(groupName, @project)
		group.new_file(filePath)
		@project.save
	end


end