require 'thor'
require 'generamba/helpers/rambafile_validator.rb'

module Generamba::CLI
  class Application < Thor

    include Generamba

    desc 'gen [MODULE_NAME] [TEMPLATE_NAME_KEY]', 'Creates a new VIPER module with a given name from a specific template'
    method_option :description, :aliases => '-d', :desc => 'Provides a full description to the module'
    def gen(module_name, template_name)

      does_rambafile_exist = Dir[RAMBAFILE_NAME].count > 0

      if (does_rambafile_exist == false)
        puts('Rambafile not found! Run `generamba setup` in the working directory instead!')
        return
      end

      rambafile_validator = Generamba::RambafileValidator.new
      rambafile_validator.validate(RAMBAFILE_NAME)

      setup_username_command = Generamba::CLI::SetupUsernameCommand.new
      setup_username_command.setup_username

      default_module_description = "#{module_name} module"
      module_description = options[:description] ? options[:description] : default_module_description

      generator = Generamba::ModuleGenerator.new()
      generator.generate_module(template_name, module_name, module_description)

    end

  end
end