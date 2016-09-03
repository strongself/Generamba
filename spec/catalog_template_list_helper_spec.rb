require_relative 'spec_helper'
require 'generamba/template/helpers/catalog_template_list_helper'

describe 'method obtain_all_templates_from_a_catalog' do

  it 'should return 0 template names for empty catalog' do
    test_catalog_path = Pathname.new('test-path/catalog')
    FakeFS do
      FileUtils.mkdir_p test_catalog_path

      list_helper = Generamba::CatalogTemplateListHelper.new
      result = list_helper.obtain_all_templates_from_a_catalog(test_catalog_path)
      expect(result.count).to eq(0)
    end
  end

  it 'should return template names for non-empty catalog' do
    test_catalog_path = Pathname.new('test-path/catalog')
    test_template_count = 5
    FakeFS do
      FileUtils.mkdir_p test_catalog_path
      for i in 1..test_template_count
        FileUtils.mkdir_p test_catalog_path.join(i.to_s)
      end

      list_helper = Generamba::CatalogTemplateListHelper.new
      result = list_helper.obtain_all_templates_from_a_catalog(test_catalog_path)
      expect(result.count).to eq(test_template_count)
    end
  end
end