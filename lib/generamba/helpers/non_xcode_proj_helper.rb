require 'fileutils'

module Generamba
  # Replaces `XcodeprojHelper` for non xcodeproj-based projects
  # Common example is generating stuff in SPM modules, which have no project file.
  class NonXcodeProjHelper
    # Recursively checks if directory contains any files
    def self.has_files?(path)
      return false unless Dir.exist?(path)
      children = Dir.children(path)
                    .filter { |child| not child.start_with?(".") }
                    .map { |child| [path, child].join("/") }

      return true if children.any? { |child| File.file?(child) }
      return children
        .select { |child| File.directory?(child) }
        .any? { |child_dir| self.has_files?(child_dir) }
    end

    # Removes directory with its contents
    def self.clear_group(path)
      FileUtils.rm_rf(path)
    end
  end
end
