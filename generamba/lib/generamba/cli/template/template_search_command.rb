require 'generamba/template/helpers/catalog_downloader.rb'

module Generamba::CLI
  class Template < Thor
    include Generamba

    desc 'search [SEARCH_STRING]', 'Searches a template with a given name in the shared GitHub catalog'
    def search(term)
      downloader = CatalogDownloader.new
      generamba_catalog_path = downloader.download_catalog(GENERAMBA_CATALOG_NAME, RAMBLER_CATALOG_REPO)

      generamba_catalog_path.children.select { |child|
        child.directory? && child.split.last.to_s[0] != '.'
      }.map { |template_path|
        template_path.split.last.to_s
      }.select { |template_name|
        template_name.include?(term)
      }.map { |template_name|
        keywords = term.squeeze.strip.split(' ').compact.uniq
        matcher = Regexp.new('(' + keywords.join('|') + ')')
        template_name.gsub(matcher) { |match| "#{match}".yellow }
      }.each { |template_name|
        puts(template_name)
      }
    end
  end
end