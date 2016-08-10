require 'git'

module Generamba
  # Provides the functionality to download template catalogs from the remote repository
  class CatalogDownloader
    # Updates all of the template catalogs and returns their filepaths.
    # If there is a Rambafile in the current directory, it also updates all of the catalogs specified there.
    #
    # @return [Array] An array of filepaths to downloaded catalogs
    def update_all_catalogs_and_return_filepaths
      does_rambafile_exist = Dir[RAMBAFILE_NAME].count > 0

      if does_rambafile_exist
        rambafile = YAML.load_file(RAMBAFILE_NAME)
        catalogs = rambafile[CATALOGS_KEY]
      end

      terminator = CatalogTerminator.new
      terminator.remove_all_catalogs

      catalog_paths = [download_catalog(GENERAMBA_CATALOG_NAME, RAMBLER_CATALOG_REPO)]

      if !catalogs.nil? && catalogs.count > 0
        catalogs.each do |catalog_url|
          catalog_name = catalog_url.split('://').last
          catalog_name = catalog_name.tr('/', '-')
          catalog_paths.push(download_catalog(catalog_name, catalog_url))
        end
      end
      catalog_paths
    end

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

      if File.exist?(current_catalog_path)
        g = Git.open(current_catalog_path)
        g.pull
      else
        Git.clone(url, name, path: catalogs_local_path)
      end

      current_catalog_path
    end
  end
end
