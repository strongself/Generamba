require 'thor'
require 'xcodeproj'
require 'liquid'
require 'git'
require 'generamba/constants/rambafile_constants.rb'
require 'generamba/helpers/print_table.rb'

module Generamba::CLI
  class Application < Thor
    include Generamba

    desc 'setup', 'Creates a Rambafile with a config for a given project'
    def setup
      properties = {}

      setup_username_command = Generamba::CLI::SetupUsernameCommand.new
      setup_username_command.setup_username

      properties[COMPANY_KEY] = ask('The company name which will be used in the headers:')

      project_name = Pathname.new(Dir.getwd).basename.to_s
      is_right_project_name = yes?("The name of your project is #{project_name}. Do you want to use it? (yes/no)")

      properties[PROJECT_NAME_KEY] = is_right_project_name ? project_name : ask_non_empty_string('The project name:', 'Project name should not be empty')
      properties[PROJECT_PREFIX_KEY]  = ask('The project prefix (if any):')

      xcodeproj_path = ask_file_with_path('*.xcodeproj',
                                          '.xcodeproj file of the project')

      properties[XCODEPROJ_PATH_KEY] = xcodeproj_path
      project = Xcodeproj::Project.open(xcodeproj_path)

      targets_prompt = ''
      project.targets.each_with_index { |element, i| targets_prompt += ("#{i}. #{element.name}" + "\n") }
      project_target = ask_index("Select the appropriate target for adding your MODULES (type the index):\n" + targets_prompt,project.targets)
      include_tests = yes?('Are you using unit-tests in this project? (yes/no)')

      test_target = nil

      if include_tests
        test_target = ask_index("Select the appropriate target for adding your TESTS (type the index):\n" + targets_prompt,project.targets)
      end

      should_add_all_modules_by_one_path = yes?('Do you want to add all your modules by one path? (yes/no)')

      project_file_path = nil
      project_group_path = nil

      test_file_path = nil
      test_group_path = nil

      if should_add_all_modules_by_one_path || include_tests
        should_use_same_paths = false

        if should_add_all_modules_by_one_path
          should_use_same_paths = yes?('Do you want to use the same paths for your files both in Xcode and the filesystem? (yes/no)')
        end

        if should_use_same_paths
          if should_add_all_modules_by_one_path
            project_group_path = ask('The default path for creating new modules:')
            project_file_path = project_group_path
          end

          if include_tests
            test_group_path = ask('The default path for creating tests:')
            test_file_path = test_group_path
          end
        else
          if should_add_all_modules_by_one_path
            project_group_path = ask('The default path for creating new modules (in Xcode groups):')
            project_file_path = ask('The default path for creating new modules (in the filesystem):')
          end

          if include_tests
            test_group_path = ask('The default path for creating tests (in Xcode groups):')
            test_file_path = ask('The default path for creating tests (in the filesystem):')
          end
        end
      end

      using_pods = yes?('Are you using Cocoapods? (yes/no)')
      if using_pods
        properties[PODFILE_PATH_KEY] = ask_file_with_path('Podfile', 'Podfile')
      end

      using_carthage = yes?('Are you using Carthage? (yes/no)')
      if using_carthage
        properties[CARTFILE_PATH_KEY] = ask_file_with_path('Cartfile', 'Cartfile')
      end

      should_add_templates = yes?('Do you want to add some well known templates to the Rambafile? (yes/no)')
      if should_add_templates
        properties[TEMPLATES_KEY] = [
            '{name: rviper_controller}',
            '{name: mvvm_controller}',
            '{name: swifty_viper}'
        ]
      end

      properties[PROJECT_TARGET_KEY] = project_target.name if project_target
      properties[PROJECT_FILE_PATH_KEY] = project_file_path if project_file_path
      properties[PROJECT_GROUP_PATH_KEY] = project_group_path if project_group_path
      properties[TEST_TARGET_KEY] = test_target.name if test_target
      properties[TEST_FILE_PATH_KEY] = test_file_path if test_file_path
      properties[TEST_GROUP_PATH_KEY] = test_group_path if test_group_path

      PrintTable.print_values(
          values: properties,
          title: 'Summary for generamba setup'
      )

      Generamba::RambafileGenerator.create_rambafile(properties)
      if should_add_templates
        puts('Rambafile successfully created! Now run `generamba template install`.'.green)
      else
        puts('Rambafile successfully created!\n Go on and find some templates in our catalog using `generamba template list` command.\n Add any of them to the Rambafile and run `generamba template install`.'.green)
      end

    end
  end
end