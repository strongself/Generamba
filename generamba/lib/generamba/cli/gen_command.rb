require 'thor'
require 'generamba/helpers/rambafile_validator.rb'
require 'generamba/helpers/xcodeproj_helper.rb'

module Generamba::CLI
  class Application < Thor

    include Generamba

    desc 'gen [MODULE_NAME] [TEMPLATE_NAME]', 'Creates a new VIPER module with a given name from a specific template'
    method_option :description, :aliases => '-d', :desc => 'Provides a full description to the module'
    method_option :module_targets, :desc => 'Specifies project targets for adding new module files'
    method_option :module_file_path, :desc => 'Specifies a location in the filesystem for new files'
    method_option :module_group_path, :desc => 'Specifies a location in Xcode groups for new files'
    method_option :module_path, :desc => 'Specifies a location (both in the filesystem and Xcode) for new files'
    method_option :test_targets, :desc => 'Specifies project targets for adding new test files'
    method_option :test_file_path, :desc => 'Specifies a location in the filesystem for new test files'
    method_option :test_group_path, :desc => 'Specifies a location in Xcode groups for new test files'
    method_option :test_path, :desc => 'Specifies a location (both in the filesystem and Xcode) for new test files'
    def gen(module_name, template_name)

      does_rambafile_exist = Dir[RAMBAFILE_NAME].count > 0

      if (does_rambafile_exist == false)
        puts('Rambafile not found! Run `generamba setup` in the working directory instead!'.red)
        return
      end

      rambafile_validator = Generamba::RambafileValidator.new
      rambafile_validator.validate(RAMBAFILE_NAME)

      setup_username_command = Generamba::CLI::SetupUsernameCommand.new
      setup_username_command.setup_username

      default_module_description = "#{module_name} module"
      module_description = options[:description] ? options[:description] : default_module_description

      rambafile = YAML.load_file(RAMBAFILE_NAME)

      template = ModuleTemplate.new(template_name)
      code_module = CodeModule.new(module_name, module_description, rambafile, options)

      project = XcodeprojHelper.obtain_project(code_module.xcodeproj_path)
      module_group_already_exists = XcodeprojHelper.module_with_group_path_already_exists(project, code_module.module_group_path)

      if (module_group_already_exists == true)
        replace_exists_module = yes?("#{module_name} module already exists. Replace? (yes/no)")
      
        if (replace_exists_module == false)
          return
        end
      end

      generator = Generamba::ModuleGenerator.new()
      generator.generate_module(module_name, code_module, template)
    end

  end
end