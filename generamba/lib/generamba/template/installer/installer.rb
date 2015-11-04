require 'generamba/template/installer/rambaspec_validator.rb'

module Generamba
  class Installer
    def install_local_template(template_name, local_path)
      rambaspec_exist = Generamba::RambaspecValidator.validate_spec_existance(template_name, local_path)

      if rambaspec_exist
        puts('The local path is right! Installing template to the current project directory...')
        FileUtils.mkdir_p template_name
        FileUtils.copy_entry(local_path, Pathname.new(template_name))
        puts("Installing is finished! Now you can call: generamba gen #{template_name}")
      end

    end
  end
end