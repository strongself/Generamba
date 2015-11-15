require 'thor'
require 'xcodeproj'
require 'liquid'
require 'tilt'
require 'git'
require 'generamba/constants/rambafile_constants.rb'

module Generamba::CLI
  class Application < Thor
    include Generamba

    desc 'setup', 'Creates a Rambafile with a config for a given project'
    def setup
      properties = {}

      git_username = Git.init.config['user.name']

      if git_username != nil && yes?("Your name in git is configured as #{git_username}. Do you want to use it in code headers? (yes/no)")
        username = git_username
      else
        username = ask_non_empty_string('The author name which will be used in the headers:', 'User name should not be empty')
      end

      Generamba::UserPreferences.save_username(username)

      properties[COMPANY_KEY] = ask('The company name which will be used in the headers:')

      project_name = Pathname.new(Dir.getwd).basename.to_s
      is_right_project_name = yes?("The name of your project is #{project_name}. Do you want to use it? (yes/no)")
      properties[PROJECT_NAME_KEY] = is_right_project_name ? project_name : ask_non_empty_string('The project name:', 'Project name should not be empty')
      properties[PROJECT_PREFIX_KEY]  = ask('The project prefix (if any):')

      project_files = Dir['*.xcodeproj']
      count = project_files.count
      if count == 1
        is_right_path = yes?("The path to a .xcodeproj file of the project is #{project_files[0]}. Do you want to use it? (yes/no)")
        xcode_path = is_right_path ? project_files[0] : ask('The path to a .xcodeproj file of the project:')
      else
        xcode_path = ask('The path to a .xcodeproj file of the project:')
      end

      properties[XCODEPROJ_PATH_KEY] = xcode_path
      project = Xcodeproj::Project.open(xcode_path)

      targets_prompt = ''
      project.targets.each_with_index { |element, i| targets_prompt += ("#{i}. #{element.name}" + "\n") }

      project_target = ask_index("Select the appropriate target for adding your MODULES (type the index):\n" + targets_prompt,project.targets)
      test_target = ask_index("Select the appropriate target for adding your TESTS (type the index):\n" + targets_prompt,project.targets)

      should_use_same_paths = yes?('Do you want to use the same paths for your files both in Xcode and the filesystem? (yes/no)')
      if should_use_same_paths
        project_group_path = ask('The default path for creating new modules:')
        project_file_path = project_group_path

        test_group_path = ask('The default path for creating tests:')
        test_file_path = test_group_path
      else
        project_group_path = ask('The default path for creating new modules (in Xcode groups):')
        project_file_path = ask('The default path for creating new modules (in the filesystem):')

        test_group_path = ask('The default path for creating tests (in Xcode groups):')
        test_file_path = ask('The default path for creating tests (in the filesystem):')
      end

      properties[PODFILE_PATH_KEY]  = ask('The Podfile path (if any):')
      properties[CARTFILE_PATH_KEY]  = ask('The Cartfile path (if any):')

      properties[PROJECT_TARGET_KEY] = project_target.name
      properties[PROJECT_FILE_PATH_KEY] = project_file_path
      properties[PROJECT_GROUP_PATH_KEY] = project_group_path
      properties[TEST_TARGET_KEY] = test_target.name
      properties[TEST_FILE_PATH_KEY] = test_file_path
      properties[TEST_GROUP_PATH_KEY] = test_group_path

      Generamba::RambafileGenerator.create_rambafile(properties)
      say('Rambafile successfully created! Now add some templates to the Rambafile and run `generamba template install`.')
    end
  end
end