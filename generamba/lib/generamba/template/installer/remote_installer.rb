require 'generamba/template/installer/abstract_installer.rb'
require 'generamba/template/helpers/rambaspec_validator.rb'
require 'git'
require 'securerandom'
require 'fileutils'

module Generamba
  class RemoteInstaller < AbstractInstaller
    def install_template(template_declaration)
      template_name = template_declaration.name
      puts("Installing #{template_name}...")

      repo_url = template_declaration.git
      # TODO: Change this dir to something unrelated
      temp_path = Dir.getwd + '/temp/' + SecureRandom.uuid
      repo = Git.clone(repo_url, template_name, :path =>  temp_path)

      rambaspec_exist = Generamba::RambaspecValidator.validate_spec_existance(template_name, temp_path + '/' + template_name)
      if rambaspec_exist == false
        FileUtils.rm_rf(temp_path)
        error_description = "Cannot find #{template_name + RAMBASPEC_EXTENSION} in the root directory of specified repository."
        raise StandardError.new(error_description)
      end

      rambaspec_valid = Generamba::RambaspecValidator.validate_spec(template_name, temp_path + '/' + template_name)
      if rambaspec_valid == false
        error_description = "#{template_name + RAMBASPEC_EXTENSION} is not valid."
        raise StandardError.new(error_description)
      end
      install_path = Pathname.new(TEMPLATES_FOLDER)
                         .join(template_name)
      FileUtils.mkdir_p install_path
      FileUtils.copy_entry(temp_path + '/' + template_name, install_path)

      FileUtils.rm_rf(temp_path)
    end
  end
end