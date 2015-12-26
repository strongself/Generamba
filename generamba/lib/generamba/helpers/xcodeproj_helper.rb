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
    # @param targets_name [String] Array of targets name
    # @param group_path [Pathname] The Xcode group path for current file
    # @param file_path [Pathname] The file path for current file
    #
    # @return [void]
    def self.add_file_to_project_and_targets(project, targets_name, group_path, file_path)
      module_group = self.retreive_or_create_group(group_path, project)
      xcode_file = module_group.new_file(File.absolute_path(file_path))

      file_name = File.basename(file_path)
      if File.extname(file_name) == '.m'
        targets_name.each do |target|
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
    def self.clear_group(project, targets_name, group_path)
      files_path = self.files_path_from_group(group_path, project)
      
      files_path.each do |file_path|
        self.remove_file_by_file_path(file_path, targets_name, project)
      end
      
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
          new_group_path = group_name
          next_group = final_group.new_group(group_name, new_group_path)
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

    # Remove build file from target build phase
    # @param file_path [String] The path of the file
    # @param targets_name [String] Array of targets
    # @param project [Xcodeproj::Project] The target xcodeproj file
    #
    # @return [Void]
    def self.remove_file_by_file_path(file_path, targets_name, project)
      build_phases = self.build_phases_from_targets(targets_name, project)
      
      build_phases.each do |build_phase|
        build_phase.files.each do |build_file|
          next if build_file.nil? || build_file.file_ref.nil?

          build_file_path = self.configure_file_ref_path(build_file.file_ref)
          
          if build_file_path == file_path
            build_phase.remove_build_file(build_file)
          end
        end
      end
    end

    # Find and return target build phases
    # @param targets_name [String] Array of targets
    # @param project [Xcodeproj::Project] The target xcodeproj file
    #
    # @return [[PBXSourcesBuildPhase]]
    def self.build_phases_from_targets(targets_name, project)
      build_phases = []

      targets_name.each do |target_name|
        xcode_target = self.obtain_target(target_name, project)
        xcode_target.build_phases.each do |build_phase|
          if build_phase.isa == 'PBXSourcesBuildPhase'
            build_phases.push(build_phase)
          end
        end
      end

      return build_phases
    end

    # Get configure file full path
    # @param file_ref [PBXFileReference] Build file
    #
    # @return [String]
    def self.configure_file_ref_path(file_ref)
      build_file_ref_path = file_ref.hierarchy_path.to_s
      build_file_ref_path[0] = ''

      return build_file_ref_path
    end

    # Get all files path from group path
    # @param group_path [String] Group path
    # @param project [Xcodeproj::Project] The target xcodeproj file
    #
    # @return [[String]]
    def self.files_path_from_group(group_path, project)
      files_path = []

      module_group = self.retreive_or_create_group(group_path, project)
      module_group.recursive_children.each do |file_ref|
        if file_ref.isa == 'PBXFileReference'
          file_ref_path = self.configure_file_ref_path(file_ref)
          files_path.push(file_ref_path)
        end
      end

      return files_path
    end

  end
end