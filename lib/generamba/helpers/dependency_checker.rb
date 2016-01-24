require 'cocoapods-core'

module Generamba

  # Provides methods for check dependencies from rambaspec in podfile
  class DependencyChecker

    # Check podfile for dependencies
    # @param dependencies [Array] Array of dependencies name
    # @param podfile_path [String] String of Podfile path
    #
    # @return [void]
    def self.check_all_required_dependencies_has_in_podfile(dependencies, podfile_path)
      return if !dependencies or dependencies.count == 0 or !podfile_path

      dependencies_names = []
      Pod::Podfile.from_file(Pathname.new(podfile_path)).dependencies.each do |dependency|
        dependencies_names.push(dependency.name.gsub(/ .*/, ''))
      end

      not_existing_dependency = []

      dependencies.each do |dependency_name|
        unless dependencies_names.include?(dependency_name)
          not_existing_dependency.push(dependency_name)
        end
      end

      if not_existing_dependency.count > 0
        puts "[Warning] Dependencies #{not_existing_dependency} missed in Podfile".yellow
      end
    end

  end

end