require 'generamba/template/processor/template_declaration.rb'
require 'generamba/template/installer/local_installer.rb'
require 'generamba/template/installer/remote_installer.rb'
require 'generamba/template/installer/catalog_installer.rb'
require 'generamba/template/helpers/catalog_downloader.rb'
require 'git'

module Generamba

  # Incapsulates logic of processing templates declaration section from Rambafile
  class TemplateProcessor

    # This method parses Rambafile, serializes templates hashes into model objects and install them
    def install_templates
      # We always clear previously installed templates to avoid conflicts in different versions
      clear_installed_templates

      rambafile = YAML.load_file(RAMBAFILE_NAME)

      templates = rambafile[TEMPLATES_KEY]

      if !templates || templates.count == 0
        puts 'You must specify at least one template in Rambafile under the key *templates*'.red
        return
      end

      # Mapping hashes to model objects
      templates = rambafile[TEMPLATES_KEY].map { |template_hash|
        Generamba::TemplateDeclaration.new(template_hash)
      }

      if !templates || templates.count == 0
        error_description = 'You must specify at least one template in Rambafile under the key *project_templates*'.red
        raise StandardError.new(error_description)
      end

      catalogs = rambafile[CATALOGS_KEY]
      # If there is at least one template from the shared catalog, we should update our local copy of the catalog
      update_catalogs_if_needed(catalogs, templates)

      templates.each do |template_declaration|
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

    # Clones remote template catalogs to the local directory
    def update_catalogs_if_needed(catalogs, templates)
      needs_update = templates.any? {|template| template.type == TemplateDeclarationType::CATALOG_TEMPLATE}

      return unless needs_update

      downloader = CatalogDownloader.new

      puts('Updating shared generamba-catalog specs...')
      downloader.download_catalog(GENERAMBA_CATALOG_NAME, RAMBLER_CATALOG_REPO)

      return unless catalogs != nil && catalogs.count > 0

      catalogs.each do |catalog_url|
        catalog_name = catalog_url.split('/').last
        puts("Updating #{catalog_name} specs...")
        downloader.download_catalog(catalog_name, catalog_url)
      end
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