require 'spec_helper'
require 'generamba/template/installer/template_installer_factory'
require 'generamba/template/processor/template_declaration'

describe 'TemplateInstallerFactory' do
  describe 'method installer_for_type' do
    subject(:factory) { Generamba::TemplateInstallerFactory.new }
    it 'returns local installer' do
      installer = factory.installer_for_type(Generamba::TemplateDeclarationType::LOCAL_TEMPLATE)
      result = installer.is_a?(Generamba::LocalInstaller)

      expect(result).to eq(true)
    end

    it 'returns remote installer' do
      installer = factory.installer_for_type(Generamba::TemplateDeclarationType::REMOTE_TEMPLATE)
      result = installer.is_a?(Generamba::RemoteInstaller)

      expect(result).to eq(true)
    end

    it 'returns catalog installer' do
      installer = factory.installer_for_type(Generamba::TemplateDeclarationType::CATALOG_TEMPLATE)
      result = installer.is_a?(Generamba::CatalogInstaller)

      expect(result).to eq(true)
    end
  end

end
