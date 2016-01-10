require 'spec_helper'
require 'fakefs/spec_helpers'
require 'generamba/template/processor/template_declaration'

describe 'method install_template' do

  context 'when template missing' do
    it 'should throw error' do
      declaration = Generamba::TemplateDeclaration.new({Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test'})
      installer = Generamba::CatalogInstaller.new

      expect {installer.install_template(declaration)}.to raise_error('Cannot find test.rambaspec in the template catalog. Try another name.'.red)
    end
  end

  it 'should install template from shared catalog' do
    template_name = 'test'
    catalog_path = Pathname.new(ENV['HOME'])
                       .join(Generamba::GENERAMBA_HOME_DIR)
                       .join(Generamba::CATALOGS_DIR)
                       .join(Generamba::GENERAMBA_CATALOG_NAME)
    template_path = catalog_path.join(template_name)

    template_install_path = Pathname.new(Generamba::TEMPLATES_FOLDER)
                                .join(template_name)

    allow(Generamba::RambaspecValidator).to receive(:validate_spec).and_return(true)
    allow(Generamba::RambaspecValidator).to receive(:validate_spec_existance).and_return(true)
    FakeFS do
      FileUtils.mkdir_p template_path

      declaration = Generamba::TemplateDeclaration.new({Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test'})
      installer = Generamba::CatalogInstaller.new
      installer.install_template(declaration)

      result = Dir.exist?(template_install_path)
      expect(result).to eq(true)
    end
  end

  it 'should install template from other catalog' do
    template_name = 'test'
    catalog_name = 'custom_catalog'
    catalog_path = Pathname.new(ENV['HOME'])
                       .join(Generamba::GENERAMBA_HOME_DIR)
                       .join(Generamba::CATALOGS_DIR)
                       .join(catalog_name)
    template_path = catalog_path.join(template_name)

    template_install_path = Pathname.new(Generamba::TEMPLATES_FOLDER)
                                .join(template_name)

    allow(Generamba::RambaspecValidator).to receive(:validate_spec).and_return(true)
    allow(Generamba::RambaspecValidator).to receive(:validate_spec_existance).and_return(true)
    FakeFS do
      FileUtils.mkdir_p template_path

      declaration = Generamba::TemplateDeclaration.new({Generamba::TEMPLATE_DECLARATION_NAME_KEY => 'test'})
      installer = Generamba::CatalogInstaller.new
      installer.install_template(declaration)

      result = Dir.exist?(template_install_path)
      expect(result).to eq(true)
    end
  end
end