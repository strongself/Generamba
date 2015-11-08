module Generamba::CLI
  class Template < Thor

    desc 'install', 'Installs all the templates specified in the Rambafile from the current directory'
    def install
      template_processor = Generamba::TemplateProcessor.new
      template_processor.install_templates
    end
  end
end