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
      catalogs_local_path = Pathname.new(ENV['HOME'])
                               .join(GENERAMBA_HOME_DIR)
                               .join(CATALOGS_DIR)
      current_catalog_path = catalogs_local_path
                                 .join(name)

      if File.exists? current_catalog_path
        g = Git.open(current_catalog_path)
        g.pull
      else
        Git.clone(url, name, :path => catalogs_local_path)
      end

      return current_catalog_path
    end
  end
end