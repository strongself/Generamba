require 'generamba/cli/template/template_install_command.rb'
require 'generamba/cli/template/template_create_command.rb'

module Generamba::CLI
  class Application < Thor
    register(Generamba::CLI::Template, 'template', 'template <command>', 'Provides a set of commands for working with templates')
  end

  class Template < Thor

  end
end