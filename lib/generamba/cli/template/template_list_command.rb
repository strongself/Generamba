require 'generamba/template/helpers/catalog_downloader'
require 'generamba/template/helpers/catalog_template_list_helper'

module Generamba::CLI
  class Template < Thor
    include Generamba

    desc 'list', 'Prints out the list of all templates available in the shared GitHub catalog'
    def list
      does_rambafile_exist = Dir[RAMBAFILE_NAME].count > 0

      if does_rambafile_exist
        rambafile = YAML.load_file(RAMBAFILE_NAME)
        catalogs = rambafile[CATALOGS_KEY]
      end

      terminator = CatalogTerminator.new
      terminator.remove_all_catalogs

      downloader = CatalogDownloader.new
      catalog_paths = [downloader.download_catalog(GENERAMBA_CATALOG_NAME, RAMBLER_CATALOG_REPO)]
      
      if catalogs != nil && catalogs.count > 0
        catalogs.each do |catalog_url|
          catalog_name = catalog_url.split('://').last
          catalog_name = catalog_name.gsub('/', '-');
          catalog_paths.push(downloader.download_catalog(catalog_name, catalog_url))
        end
      end

      catalog_template_list_helper = CatalogTemplateListHelper.new

      templates = []
      catalog_paths.each do |path|
        templates += catalog_template_list_helper.obtain_all_templates_from_a_catalog(path)
        templates = templates.uniq
      end

      templates.each do |template_name|
        puts(template_name)
      end
    end
  end
end