require 'generamba/template/installer/abstract_installer.rb'
require 'generamba/template/helpers/rambaspec_validator.rb'
require 'fileutils'
require 'tmpdir'

module Generamba

  # Incapsulates the logic of installing Generamba templates from the template catalog
  class CatalogInstaller < AbstractInstaller
    def install_template(template_declaration)
      template_name = template_declaration.name
      puts("Installing #{template_name}...")

      template_name = template_declaration.name
      catalogs_path = Pathname.new(ENV['HOME'])
                         .join(GENERAMBA_HOME_DIR)
                         .join(CATALOGS_DIR)
      catalogs_path.children.select { |child|
        child.directory?
      }.each { |catalog_name|
        catalog_path = catalogs_path.join(catalog_name)
        process_catalog(catalog_path, template_name)
      }
    end

    private

    # Browses a given catalog and installs found template
    def process_catalog(catalog_path, template_name)
      template_path = catalog_path.join(template_name)

      rambaspec_exist = Generamba::RambaspecValidator.validate_spec_existance(template_name, template_path)

      unless rambaspec_exist
        error_description = "Cannot find #{template_name + RAMBASPEC_EXTENSION} in the template catalog. Try another name.".red
        raise StandardError.new(error_description)
      end

      rambaspec_valid = Generamba::RambaspecValidator.validate_spec(template_name, template_path)
      unless rambaspec_valid
        error_description = "#{template_name + RAMBASPEC_EXTENSION} is not valid.".red
        raise StandardError.new(error_description)
      end

      install_path = Pathname.new(TEMPLATES_FOLDER)
                         .join(template_name)
      FileUtils.mkdir_p install_path

      src = template_path.to_s + '/.'
      FileUtils.cp_r(src, install_path)
    end
  end
end