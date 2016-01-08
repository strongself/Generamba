require 'spec_helper'

describe 'CatalogDownloader' do
  include FakeFS::SpecHelpers

  describe 'method download_catalog' do
    it 'should clone catalog from remote repository' do
      catalog_name = 'catalog'
      catalog_url = 'https://github.com/rambler-ios/generamba-catalog'

      allow(Git).to receive(:clone)
      expect(Git).to receive(:clone).with(catalog_url, catalog_name, any_args)

      downloader = Generamba::CatalogDownloader.new
      downloader.download_catalog(catalog_name, catalog_url)
    end

    it 'should return local catalog directory' do
      catalog_name = 'catalog'
      catalog_url = 'https://github.com/rambler-ios/generamba-catalog'
      catalogs_local_path = Pathname.new(ENV['HOME'])
                                .join(Generamba::GENERAMBA_HOME_DIR)
                                .join(Generamba::CATALOGS_DIR)
      current_catalog_path = catalogs_local_path
                                 .join(catalog_name)

      allow(Git).to receive(:clone)

      downloader = Generamba::CatalogDownloader.new
      result = downloader.download_catalog(catalog_name, catalog_url)
      expect(result).to eq(current_catalog_path)
    end
  end
end
