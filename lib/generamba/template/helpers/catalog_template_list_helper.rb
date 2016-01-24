require 'git'

module Generamba

  # Provides the functionality to list all of the templates, available in the catalog
  class CatalogTemplateListHelper

    # Finds out all of the templates located in a catalog
    #
    # @param catalog_path [Pathname] The path to a template catalog
    #
    # @return [Array] An array with template names
    def obtain_all_templates_from_a_catalog(catalog_path)
      template_names = []
      catalog_path.children.select { |child|
        File.directory?(child) && child.split.last.to_s[0] != '.'
      }.map { |template_path|
        template_path.split.last.to_s
      }.each { |template_name|
        template_names.push(template_name)
      }
      return template_names
    end
  end
end