require 'thor'

module Generamba::CLI
  class Application < Thor

    desc 'gen [MODULE_NAME] [TEMPLATE_NAME]', 'Creates a new VIPER module with a given name from a specific template'
    method_option :description, :aliases => '-d', :desc => 'Provides a full description to the module'
    def gen(module_name, template_name)

      does_rambafile_exist = Dir['Rambafile'].count > 0

      if (does_rambafile_exist == false)
        puts('Rambafile not found! Run `generamba setup` in the working directory instead!')
        return
      end

      default_module_description = "#{module_name} module"
      module_description = options[:description] ? options[:description] : default_module_description

      generator = Generamba::ModuleGenerator.new()
      generator.generate_module(template_name, module_name, module_description)

    end

  end
end