require_relative 'spec_helper'
require 'generamba/template/helpers/catalog_template_search_helper'

describe 'method search_templates_in_a_catalog' do
  it 'should return zero templates if no matches' do
    test_catalog_path = Pathname.new('test-path/catalog')
    FakeFS do
      FileUtils.mkdir_p test_catalog_path

      search_helper = Generamba::CatalogTemplateSearchHelper.new
      result = search_helper.search_templates_in_a_catalog(test_catalog_path, 'viper')
      expect(result.count).to eq(0)
    end
  end

  it 'should return templates if there are matches' do
    test_catalog_path = Pathname.new('test-path/catalog')
    test_search_term = 'viper'
    test_viper_template_path = test_catalog_path.join("#{test_search_term}-template")
    FakeFS do
      FileUtils.mkdir_p test_viper_template_path

      search_helper = Generamba::CatalogTemplateSearchHelper.new
      result = search_helper.search_templates_in_a_catalog(test_catalog_path, test_search_term)
      expect(result.count).to eq(1)
    end
  end
end