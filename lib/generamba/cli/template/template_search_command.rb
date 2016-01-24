require 'generamba/template/helpers/catalog_downloader.rb'
require 'generamba/template/helpers/catalog_template_search_helper'

module Generamba::CLI
  class Template < Thor
    include Generamba

    desc 'search [SEARCH_STRING]', 'Searches a template with a given name in the shared GitHub catalog'
    def search(term)
      downloader = CatalogDownloader.new
      generamba_catalog_path = downloader.download_catalog(GENERAMBA_CATALOG_NAME, RAMBLER_CATALOG_REPO)

      catalog_template_search_helper = CatalogTemplateSearchHelper.new
      templates = catalog_template_search_helper.search_templates_in_a_catalog(generamba_catalog_path, term)
      templates.map { |template_name|
        keywords = term.squeeze.strip.split(' ').compact.uniq
        matcher = Regexp.new('(' + keywords.join('|') + ')')
        template_name.gsub(matcher) { |match| "#{match}".yellow }
      }.each { |template_name|
        puts(template_name)
      }
    end
  end
end