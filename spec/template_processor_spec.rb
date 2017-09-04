require_relative 'spec_helper'
require 'fakefs/spec_helpers'

describe 'TemplateProcessor' do
  include FakeFS::SpecHelpers

  describe 'method install_templates' do
    it 'should clear previously installed templates' do
      FakeFS do
        installed_templates_path = Pathname.new(Generamba::TEMPLATES_FOLDER)
        FileUtils.mkdir_p(installed_templates_path)

        processor = Generamba::TemplateProcessor.new(nil, nil)
        processor.install_templates({})
        result = installed_templates_path.exist?

        expect(result).to eq(false)
      end
    end

    it 'should check for templates declaration' do
      expect(STDOUT).to receive(:puts).with('You must specify at least one template in Rambafile under the key *templates*'.red)
      processor = Generamba::TemplateProcessor.new(nil, nil)
      processor.install_templates({})
    end

    it 'should update shared catalog if needed' do
      rambafile = {
          Generamba::TEMPLATES_KEY => [
              {
                  Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test'
              }
          ]
      }
      downloader = instance_double('Generamba::CatalogDownloader')
      allow(downloader).to receive(:download_catalog)

      mock_installer = instance_double('Generamba::CatalogInstaller')
      allow(mock_installer).to receive(:install_template)
      installer_factory = instance_double('Generamba::TemplateInstallerFactory')
      allow(installer_factory).to receive(:installer_for_type).and_return(mock_installer)

      processor = Generamba::TemplateProcessor.new(downloader, installer_factory)
      processor.install_templates(rambafile)

      expect(downloader).to have_received(:download_catalog).with(Generamba::GENERAMBA_CATALOG_NAME, Generamba::RAMBLER_CATALOG_REPO)
    end

    it 'should update other catalogs if needed' do
      test_catalog_url = 'http://github.com/catalog1'
      test_catalog_name = test_catalog_url.split('://').last
      test_catalog_name = test_catalog_name.gsub('/', '-');
      rambafile = {
          Generamba::TEMPLATES_KEY => [
              {
                  Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test'
              }
          ],
          Generamba::CATALOGS_KEY => [
              test_catalog_url
          ]
      }

      downloader = instance_double('Generamba::CatalogDownloader')
      allow(downloader).to receive(:download_catalog)

      mock_installer = instance_double('Generamba::CatalogInstaller')
      allow(mock_installer).to receive(:install_template)
      installer_factory = instance_double('Generamba::TemplateInstallerFactory')
      allow(installer_factory).to receive(:installer_for_type).and_return(mock_installer)

      processor = Generamba::TemplateProcessor.new(downloader, installer_factory)
      processor.install_templates(rambafile)
      expect(downloader).to have_received(:download_catalog).with(test_catalog_name, test_catalog_url)
    end

    it 'should install local templates' do
      rambafile = {
          Generamba::TEMPLATES_KEY => [
              {
                  Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test',
                  Generamba::TEMPLATE_DECLARATION_LOCAL_KEY => 'path'
              }
          ]
      }

      mock_installer = instance_double('Generamba::LocalInstaller')
      allow(mock_installer).to receive(:install_template)
      installer_factory = instance_double('Generamba::TemplateInstallerFactory')
      allow(installer_factory).to receive(:installer_for_type).and_return(mock_installer)

      processor = Generamba::TemplateProcessor.new(nil, installer_factory)
      processor.install_templates(rambafile)

      expect(installer_factory).to have_received(:installer_for_type).with(Generamba::TemplateDeclarationType::LOCAL_TEMPLATE)
      expect(mock_installer).to have_received(:install_template)
    end

    it 'should install remote templates' do
      rambafile = {
          Generamba::TEMPLATES_KEY => [
              {
                  Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test',
                  Generamba::TEMPLATE_DECLARATION_GIT_KEY => 'path'
              }
          ]
      }

      mock_installer = instance_double('Generamba::RemoteInstaller')
      allow(mock_installer).to receive(:install_template)
      installer_factory = instance_double('Generamba::TemplateInstallerFactory')
      allow(installer_factory).to receive(:installer_for_type).and_return(mock_installer)

      processor = Generamba::TemplateProcessor.new(nil, installer_factory)
      processor.install_templates(rambafile)

      expect(installer_factory).to have_received(:installer_for_type).with(Generamba::TemplateDeclarationType::REMOTE_TEMPLATE)
      expect(mock_installer).to have_received(:install_template)
    end

    it 'should install catalog templates' do
      rambafile = {
          Generamba::TEMPLATES_KEY => [
              {
                  Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test'
              }
          ]
      }
      downloader = instance_double('Generamba::CatalogDownloader')
      allow(downloader).to receive(:download_catalog)

      mock_installer = instance_double('Generamba::CatalogInstaller')
      allow(mock_installer).to receive(:install_template)
      installer_factory = instance_double('Generamba::TemplateInstallerFactory')
      allow(installer_factory).to receive(:installer_for_type).and_return(mock_installer)

      processor = Generamba::TemplateProcessor.new(downloader, installer_factory)
      processor.install_templates(rambafile)

      expect(installer_factory).to have_received(:installer_for_type).with(Generamba::TemplateDeclarationType::CATALOG_TEMPLATE)
      expect(mock_installer).to have_received(:install_template)
    end

    it 'should clear previously downloaded catalogs' do
      rambafile = {
          Generamba::TEMPLATES_KEY => [
              {
                  Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test'
              }
          ]
      }
      downloader = instance_double('Generamba::CatalogDownloader')
      allow(downloader).to receive(:download_catalog)

      mock_installer = instance_double('Generamba::CatalogInstaller')
      allow(mock_installer).to receive(:install_template)
      installer_factory = instance_double('Generamba::TemplateInstallerFactory')
      allow(installer_factory).to receive(:installer_for_type).and_return(mock_installer)

      FakeFS do
        catalogs_path = Pathname.new(ENV['HOME'])
                            .join(Generamba::GENERAMBA_HOME_DIR)
                            .join(Generamba::CATALOGS_DIR)
        custom_catalog_path = catalogs_path.join('custom-catalog')
        FileUtils.mkdir_p(custom_catalog_path)

        processor = Generamba::TemplateProcessor.new(downloader, installer_factory)
        processor.install_templates(rambafile)
        result = custom_catalog_path.exist?

        expect(result).to eq(false)
      end
    end
  end
end
