module Generamba::CLI
  class Template < Thor

    desc 'install', 'Installs all the templates specified in the Rambafile from the current directory'
    def install
      does_rambafile_exist = Dir[RAMBAFILE_NAME].count > 0

      unless does_rambafile_exist
        puts('Rambafile not found! Run `generamba setup` in the working directory instead!'.red)
        return
      end

      catalog_downloader = Generamba::CatalogDownloader.new
      installer_factory = Generamba::TemplateInstallerFactory.new
      template_processor = Generamba::TemplateProcessor.new(catalog_downloader, installer_factory)

      rambafile = YAML.load_file(RAMBAFILE_NAME)
      template_processor.install_templates(rambafile)
    end
  end
end