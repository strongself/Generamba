require 'generamba/template/processor/template_declaration.rb'
require 'generamba/template/installer/local_installer.rb'
require 'generamba/template/installer/remote_installer.rb'
require 'generamba/template/installer/catalog_installer.rb'
require 'git'

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

        # It's unnecessary to clone the template catalog if there are no appropriate templates in the Rambafile
        update_shared_catalog_if_needed if template_declaration.type == TemplateDeclarationType::CATALOG_TEMPLATE

        template_declaration.install(strategy)
      end
    end

    private

    # Clears all of the currently installed templates
    def clear_installed_templates
      install_path = Pathname.new(TEMPLATES_FOLDER)
      FileUtils.rm_rf(Dir.glob(install_path))
    end

    # Clones remote template catalog to the local directory
    def update_shared_catalog_if_needed
      # We should update the catalog exactly once
      if @is_catalog_updated == true
        return
      end
      puts('Updating shared generamba-catalog specs...')

      # Cloning repo to the local directory
      catalog_local_path = Pathname.new(Dir.getwd).join(CATALOGS_DIR)
      FileUtils.rm_rf catalog_local_path
      FileUtils.mkdir_p catalog_local_path

      Git.clone(RAMBLER_CATALOG_REPO, 'generamba-catalog', :path => catalog_local_path)
    end

    # Provides the appropriate strategy for a given template type
    def strategy_for_type(type)
      case type
        when TemplateDeclarationType::LOCAL_TEMPLATE
          return Generamba::LocalInstaller.new
        when TemplateDeclarationType::REMOTE_TEMPLATE
          return Generamba::RemoteInstaller.new
        when TemplateDeclarationType::CATALOG_TEMPLATE
          return Generamba::CatalogInstaller.new
        else
          return nil
      end
    end
  end
end