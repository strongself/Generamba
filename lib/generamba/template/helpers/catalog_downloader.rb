require 'git'

module Generamba

  # Provides the functionality to download template catalogs from the remote repository
  class CatalogDownloader

    # Clones a template catalog from a remote repository
    #
    # @param name [String] The name of the template catalog
    # @param url [String] The url of the repository
    #
    # @return [Pathname] A filepath to the downloaded catalog
    def download_catalog(name, url)
      catalog_local_path = Pathname.new(ENV['HOME'])
                               .join(GENERAMBA_HOME_DIR)
                               .join(CATALOGS_DIR)
      FileUtils.rm_rf catalog_local_path
      FileUtils.mkdir_p catalog_local_path

      Git.clone(url, name, :path => catalog_local_path)

      return catalog_local_path
                 .join(name)
    end
  end
end