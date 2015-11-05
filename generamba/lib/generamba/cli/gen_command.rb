require 'thor'

module Generamba::CLI
  class Application < Thor

    desc 'gen [MODULE_NAME]', 'Creates a new VIPER module with a given name'
    method_option :template, :aliases => '-t', :desc => 'Provides a name for the template to be used'
    method_option :description, :aliases => '-d', :desc => 'Provides a full description to the module'
    def gen(module_name)

      does_rambafile_exist = Dir['Rambafile'].count > 0

      if (does_rambafile_exist == false)
        puts('Rambafile not found! Run `generamba setup` in the working directory instead!')
        return
      end

      default_module_description = "#{module_name} module"
      module_description = options[:description] ? options[:description] : default_module_description
      template_name = options[:template] ? options[:template] : 'rambler_viper_controller'

      generator = Generamba::ModuleGenerator.new()
      generator.generate_module(template_name, module_name, module_description)

    end

  end
end