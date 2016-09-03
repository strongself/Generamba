require 'thor'
require 'generamba/helpers/print_table.rb'
require 'generamba/helpers/rambafile_validator.rb'
require 'generamba/helpers/xcodeproj_helper.rb'
require 'generamba/helpers/dependency_checker.rb'
require 'generamba/helpers/gen_command_table_parameters_formatter.rb'
require 'generamba/helpers/module_validator.rb'

module Generamba::CLI
  class Application < Thor

    include Generamba

    desc 'gen [MODULE_NAME] [TEMPLATE_NAME]', 'Creates a new VIPER module with a given name from a specific template'
    method_option :description, :aliases => '-d', :desc => 'Provides a full description to the module'
    method_option :author, :desc => 'Specifies the author name for generated module'
    method_option :project_targets, :desc => 'Specifies project targets for adding new module files'
    method_option :module_file_path, :desc => 'Specifies a location in the filesystem for new files'
    method_option :module_group_path, :desc => 'Specifies a location in Xcode groups for new files'
    method_option :module_path, :desc => 'Specifies a location (both in the filesystem and Xcode) for new files'
    method_option :test_targets, :desc => 'Specifies project targets for adding new test files'
    method_option :test_file_path, :desc => 'Specifies a location in the filesystem for new test files'
    method_option :test_group_path, :desc => 'Specifies a location in Xcode groups for new test files'
    method_option :test_path, :desc => 'Specifies a location (both in the filesystem and Xcode) for new test files'
    method_option :custom_parameters, :type => :hash, :default => {}, :desc => 'Specifies extra parameters in format `key1:value1 key2:value2` for usage during code generation'
    def gen(module_name, template_name)

      does_rambafile_exist = Dir[RAMBAFILE_NAME].count > 0

      unless does_rambafile_exist
        puts('Rambafile not found! Run `generamba setup` in the working directory instead!'.red)
        return
      end

      rambafile_validator = Generamba::RambafileValidator.new
      rambafile_validator.validate(RAMBAFILE_NAME)

      setup_username_command = Generamba::CLI::SetupUsernameCommand.new
      setup_username_command.setup_username

      rambafile = YAML.load_file(RAMBAFILE_NAME)

      parameters = GenCommandTableParametersFormatter.prepare_parameters_for_displaying(rambafile)
      PrintTable.print_values(
          values: parameters,
          title: "Summary for gen #{module_name}"
      )

      code_module = CodeModule.new(module_name, rambafile, options)

      module_validator = ModuleValidator.new
      module_validator.validate(code_module)

      template = ModuleTemplate.new(template_name)

      DependencyChecker.check_all_required_dependencies_has_in_podfile(template.dependencies, code_module.podfile_path)
      DependencyChecker.check_all_required_dependencies_has_in_cartfile(template.dependencies, code_module.cartfile_path)

      project = XcodeprojHelper.obtain_project(code_module.xcodeproj_path)
      module_group_already_exists = XcodeprojHelper.module_with_group_path_already_exists(project, code_module.module_group_path)

      if module_group_already_exists
        replace_exists_module = yes?("#{module_name} module already exists. Replace? (yes/no)")
      
        unless replace_exists_module
          return
        end
      end

      generator = Generamba::ModuleGenerator.new()
      generator.generate_module(module_name, code_module, template)
    end

  end
end