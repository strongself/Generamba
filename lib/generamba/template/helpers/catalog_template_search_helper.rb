module Generamba

  # Provides the functionality to search templates, in catalogs
  class CatalogTemplateSearchHelper

    # Finds out all of the templates located in a catalog
    #
    # @param catalog_path [Pathname] The path to a template catalog
    #
    # @return [Array] An array with template names
    def search_templates_in_a_catalog(catalog_path, search_term)
      template_names = []

      catalog_path.children.select { |child|
        File.directory?(child) && child.split.last.to_s[0] != '.'
      }.map { |template_path|
        template_path.split.last.to_s
      }.select { |template_name|
        template_name.include?(search_term)
      }.each { |template_name|
        template_names.push(template_name)
      }

      return template_names
    end
  end
end