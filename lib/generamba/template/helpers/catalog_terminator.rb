module Generamba

  # Provides a functionality to terminate all previously installed catalogs
  #
  # @return [Void]
  class CatalogTerminator
    def remove_all_catalogs
      catalogs_path = Pathname.new(ENV['HOME'])
                          .join(GENERAMBA_HOME_DIR)
                          .join(CATALOGS_DIR)
      if Dir.exist?(catalogs_path) == false
        FileUtils.mkdir_p catalogs_path
      end
      catalogs_path.children.select { |child|
        child.directory? && child.split.last.to_s[0] != '.'
      }.each { |catalog_path|
        FileUtils.rm_rf(catalog_path)
      }
    end
  end
end