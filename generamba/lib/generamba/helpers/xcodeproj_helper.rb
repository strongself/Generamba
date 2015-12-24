module Generamba

  # Provides a number of helper methods for working with xcodeproj gem
  class XcodeprojHelper

    # Returns a PBXProject class for a given name
    # @param project_name [String] The name of the project file
    #
    # @return [Xcodeproj::Project]
    def self.obtain_project(project_name)
      Xcodeproj::Project.open(project_name)
    end

    # Adds a provided file to a specific Project and Target
    # @param project [Xcodeproj::Project] The target xcodeproj file
    # @param targets [AbstractTarget] Array of tatgets
    # @param group_path [Pathname] The Xcode group path for current file
    # @param file_path [Pathname] The file path for current file
    #
    # @return [void]
    def self.add_file_to_project_and_targets(project, targets, group_path, file_path)
      module_group = self.retreive_or_create_group(group_path, project)
      xcode_file = module_group.new_file(File.absolute_path(file_path))

      file_name = File.basename(file_path)
      if File.extname(file_name) == '.m'
        targets.each do |target|
          xcode_target = self.obtain_target(target, project)
          xcode_target.add_file_references([xcode_file])
        end
      end
    end

    # Recursively clears children of te given group
    # @param project [Xcodeproj::Project] The working Xcode project file
    # @param group_path [Pathname] The full group path
    #
    # @return [Void]
    def self.clear_group(project, group_path)
      module_group = self.retreive_or_create_group(group_path, project)
      module_group.clear
    end

    private

    # Finds or creates a group in a xcodeproj file with a given path
    # @param group_path [Pathname] The full group path
    # @param project [Xcodeproj::Project] The working Xcode project file
    #
    # @return [PBXGroup]
    def self.retreive_or_create_group(group_path, project)
      group_names = group_names_from_group_path(group_path)

      final_group = project

      group_names.each do |group_name|
        next_group = final_group[group_name]
        if (next_group == nil)
          next_group = final_group.new_group(group_name, group_name)
        end

        final_group = next_group
      end

      return final_group
    end

    # Returns an AbstractTarget class for a given name
    # @param target_name [String] The name of the target
    # @param project [Xcodeproj::Project] The target xcodeproj file
    #
    # @return [Xcodeproj::AbstractTarget]
    def self.obtain_target(target_name, project)
      project.targets.each do |target|
        if target.name == target_name
          return target
        end
      end

      error_description = "Cannot find a target with name #{target_name} in Xcode project".red
      raise StandardError.new(error_description)
    end

    # Splits the provided Xcode group path to an array of separate groups
    # @param group_path The full group path
    #
    # @return [[String]]
    def self.group_names_from_group_path(group_path)
      groups = group_path.to_s.split('/')
      return groups
    end
  end
end