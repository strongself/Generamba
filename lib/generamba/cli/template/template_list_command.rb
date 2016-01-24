require 'generamba/template/helpers/catalog_downloader'
require 'generamba/template/helpers/catalog_template_list_helper'

module Generamba::CLI
  class Template < Thor
    include Generamba

    desc 'list', 'Prints out the list of all templates available in the shared GitHub catalog'
    def list
      downloader = CatalogDownloader.new
      catalog_template_list_helper = CatalogTemplateListHelper.new

      templates = []
      catalog_paths = downloader.update_all_catalogs_and_return_filepaths
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