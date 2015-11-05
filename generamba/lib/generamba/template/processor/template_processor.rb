require 'generamba/template/processor/template_declaration.rb'
require 'generamba/template/installer/local_installer.rb'
require 'generamba/template/installer/remote_installer.rb'

module Generamba
  class TemplateProcessor
    def install_templates
      rambafile = YAML.load_file('Rambafile')

      templates = rambafile['project_templates']
      if !templates || templates.count == 0
        error_description = 'You must specify at least one template in Rambafile under the key *project_templates*'
        raise StandardError.new(error_description)
      end

      templates.each do |template|
        template_declaration = Generamba::TemplateDeclaration.new(template)
        strategy = strategy_for_type(template_declaration.type)
        template_declaration.install(strategy)
      end
    end

    private
    def strategy_for_type(type)
      case type
        when TemplateDeclarationType::LOCAL_TEMPLATE
          return Generamba::LocalInstaller.new
        when TemplateDeclarationType::REMOTE_TEMPLATE
          return Generamba::RemoteInstaller.new
        else
          return nil
      end
    end
  end
end