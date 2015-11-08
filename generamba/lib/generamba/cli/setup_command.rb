require 'thor'
require 'xcodeproj'
require 'liquid'
require 'tilt'
require 'git'

module Generamba::CLI
  class Application < Thor

    desc 'setup', 'Creates a Rambafile with a config for a given project'
    def setup
      properties = {}

      git_username = Git.init.config['user.name']

      if git_username != nil && yes?("Your name in git is configured as #{git_username}. Do you want to use it in code headers? (yes/no)")
        properties['author_name'] = git_username
      else
        properties['author_name'] = ask_non_empty_string('The author name which will be used in the headers:','User name should not be empty')
      end

      properties['author_company'] = ask('The company name which will be used in the headers:')

      project_name = Pathname.new(Dir.getwd).basename.to_s
      is_right_project_name = yes?("The name of your project is #{project_name}. Do you want to use it? (yes/no)")
      properties['project_name'] = is_right_project_name ? project_name : ask_non_empty_string('The project name:','Project name should not be empty')
      properties['prefix']  = ask('The project prefix (if any):')

      project_files = Dir['*.xcodeproj']
      count = project_files.count
      if count == 1
        is_right_path = yes?("The path to a .xcodeproj file of the project is #{project_files[0]}. Do you want to use it? (yes/no)")
        xcode_path = is_right_path ? File.absolute_path(project_files[0]) : ask('The path to a .xcodeproj file of the project:')
      else
        xcode_path = ask('The path to a .xcodeproj file of the project:')
      end

      properties['xcodeproj_path'] = xcode_path
      project = Xcodeproj::Project.open(xcode_path)

      targets_prompt = ''
      project.targets.each_with_index { |element, i| targets_prompt += ("#{i}. #{element.name}" + "\n") }

      project_target = ask_index("Select the appropriate target for adding your MODULES (type the index):\n" + targets_prompt,project.targets)
      test_target = ask_index("Select the appropriate target for adding your TESTS (type the index):\n" + targets_prompt,project.targets)

      project_group_path = ask('The default group path for creating new modules:')
      project_file_path = ask('The default file path for creating new modules:')

      test_group_path = ask('The default group path for creating tests:')
      test_file_path = ask('The default file path for creating tests:')

      properties['project_target'] = project_target.name
      properties['project_file_path'] = project_file_path
      properties['project_group_path'] = project_group_path
      properties['test_target'] = test_target.name
      properties['test_file_path'] = test_file_path
      properties['test_group_path'] = test_group_path

      Generamba::RambafileGenerator.create_rambafile(properties)
      puts('Rambafile successfully created! Now run generamba gen [MODULE_NAME]')
    end
  end
end