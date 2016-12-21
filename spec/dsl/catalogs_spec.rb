describe Generamba::DSL::Catalogs do
  before(:each) do
    allow_any_instance_of(Generamba::Service::RemotePlugin)
      .to receive(:cached_plugin_dir).and_return('spec/dummy/local_template')
    allow_any_instance_of(Generamba::Service::RemotePlugin)
      .to receive(:sync).and_return(nil)
  end

  describe '#catalog' do
    let!(:invoke_catalog_method) {
      catalog 'https://github.com/some_user/generamba-catalogs', branch: :master
    }

    it 'should generate `template:install` task' do
      expect(Rake.application.instance_variable_get('@tasks')['template:install'])
      .to be_kind_of Rake::Task
    end

    it 'should read catalog data' do
      expect(Rake.application.raw_templates_list['local_template']).not_to be_empty
    end
  end
end
