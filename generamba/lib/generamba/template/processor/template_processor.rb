require 'generamba/template/processor/template_declaration.rb'
require 'generamba/template/installer/local_installer.rb'
require 'generamba/template/installer/remote_installer.rb'

module Generamba

  # Incapsulates logic of processing templates declaration section from Rambafile
  class TemplateProcessor

    # This method parses Rambafile, serializes templates hashes into model objects and install them
    def install_templates

      # We always clear previously installed templates to avoid conflicts in different versions
      clear_installed_templates

      rambafile = YAML.load_file(RAMBAFILE_NAME)

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

    # Clears all of the currently installed templates
    def clear_installed_templates
      install_path = Pathname.new(TEMPLATES_FOLDER)
      FileUtils.rm_rf(Dir.glob(install_path))
    end

    # Provides the appropriate strategy for a given template type
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