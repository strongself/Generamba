require 'generamba/template/helpers/catalog_downloader.rb'

module Generamba::CLI
  class Template < Thor
    include Generamba

    desc 'list', 'Prints out the list of all templates available in the shared GitHub catalog'
    def list
      downloader = CatalogDownloader.new
      generamba_catalog_path = downloader.download_catalog(GENERAMBA_CATALOG_NAME, RAMBLER_CATALOG_REPO)

      generamba_catalog_path.children.select { |child|
        child.directory? && child.split.last.to_s[0] != '.'
      }.map { |template_path|
        template_path.split.last.to_s
      }.each { |template_name|
        puts(template_name)
      }
    end
  end
end