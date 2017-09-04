require_relative 'spec_helper'

describe 'CatalogDownloader' do
  describe 'method download_catalog' do

    it 'should pull catalog from remote repository if directory exists' do
      catalog_name = 'catalog'
      catalog_url = 'https://github.com/rambler-digital-solutions/generamba-catalog'

      allow(File).to receive(:exists?) { true }

      git = instance_double("Base")

      allow(Git).to receive(:open) { git }
      allow(git).to receive(:pull)
      expect(git).to receive(:pull)

      downloader = Generamba::CatalogDownloader.new
      downloader.download_catalog(catalog_name, catalog_url)
    end

    it 'should clone catalog from remote repository if directory not exists' do
      catalog_name = 'catalog'
      catalog_url = 'https://github.com/rambler-digital-solutions/generamba-catalog'

      allow(File).to receive(:exists?) { false }

      allow(Git).to receive(:clone)
      expect(Git).to receive(:clone).with(catalog_url, catalog_name, any_args)

      downloader = Generamba::CatalogDownloader.new
      downloader.download_catalog(catalog_name, catalog_url)
    end

    it 'should return local catalog directory' do
      catalog_name = 'catalog'
      catalog_url = 'https://github.com/rambler-digital-solutions/generamba-catalog'
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
