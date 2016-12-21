describe Generamba::DSL::Templates do
  describe '#template' do
    context 'when template was synced' do
      before(:each) do
        allow_any_instance_of(Generamba::Service::RemotePlugin)
        .to receive(:cached_plugin_dir).and_return('spec/dummy/local_template')
        allow_any_instance_of(Generamba::Service::RemotePlugin)
        .to receive(:sync).and_return(nil)

        catalog 'https://github.com/some_user/generamba-catalogs', branch: :master
      end

      it 'should load data about this template if selected right template' do
        template :local_template

        expect(Rake.application.selected_templates).to include(:local_template)
      end

      it 'should raise error if selected unknown template' do
        expect { template :unknown_template }.to raise_error(Generamba::Error::UndefinedTemplateName)
      end

      it 'should raise error if selected unknown version' do
        expect { template :local_template, version: '2.1' }
          .to raise_error(Generamba::Error::UndefinedTemplateVersion)
      end
    end

    context 'when template is local template' do
      it 'should load data about this template' do
        template :local_template, path: 'spec/dummy/local_template'

        expect(Rake.application.selected_templates).to include(:local_template)
      end
    end
  end

  describe '#load_generamba_temlates_data' do
    it 'should read catalog data if path is correct' do
      load_generamba_temlates_data 'spec/dummy/local_template'

      expect(Rake.application.raw_templates_list['local_template']).not_to be_empty
    end

    it 'should raise error if path does not contain `rambaspec` file' do
      expect { load_generamba_temlates_data 'spec/dummy/local_template/Code' }
        .to raise_error(Generamba::Error::IncorrectRepository)
    end
  end
end
