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

      catalog_path = catalogs_path.children.select { |child|
        child.directory? && child.split.last.to_s[0] != '.'
      }.select { |catalog_path|
        template_path = browse_catalog_for_a_template(catalog_path, template_name)
        template_path != nil
      }.first

      if catalog_path == nil
        error_description = "Cannot find #{template_name} in any catalog. Try another name.".red
        raise StandardError.new(error_description)
      end

      template_path = catalog_path.join(template_name)
      rambaspec_exist = Generamba::RambaspecValidator.validate_spec_existance(template_name, template_path)
      unless rambaspec_exist
        error_description = "Cannot find #{template_name + RAMBASPEC_EXTENSION} in the template catalog #{catalog_path}. Try another name.".red
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

    private

    # Browses a given catalog and returns a template path
    #
    # @param catalog_path [Pathname] A path to a catalog
    # @param template_name [String] A name of the template
    #
    # @return [Pathname] A path to a template, if found
    def browse_catalog_for_a_template(catalog_path, template_name)
      template_path = catalog_path.join(template_name)

      if Dir.exist?(template_path)
        return template_path
      end

      return nil
    end
  end
end