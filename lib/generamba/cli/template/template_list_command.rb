require 'generamba/template/helpers/catalog_downloader'
require 'generamba/template/helpers/catalog_template_list_helper'

module Generamba::CLI
  class Template < Thor
    include Generamba

    desc 'list', 'Prints out the list of all templates available in the shared GitHub catalog'
    def list
      downloader = CatalogDownloader.new
      generamba_catalog_path = downloader.download_catalog(GENERAMBA_CATALOG_NAME, RAMBLER_CATALOG_REPO)

      catalog_template_list_helper = CatalogTemplateListHelper.new
      templates = catalog_template_list_helper.obtain_all_templates_from_a_catalog(generamba_catalog_path)

      templates.each do |template_name|
        puts(template_name)
      end
    end
  end
end