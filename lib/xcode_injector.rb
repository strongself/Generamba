require 'xcodeproj'

class Generamba::XcodeInjector
	def initialize
	end

	def test
		


	end

	def listFilesInGroup(groupName)
		project = Xcodeproj::Project.open(File.dirname(__FILE__) + "/SynchronizationProblems.xcodeproj")

		groups = groupName.split("/")
		finalGroup = project

		groups.each do |group|
			finalGroup = finalGroup[group]
		end

		print(finalGroup.files)
	end
end