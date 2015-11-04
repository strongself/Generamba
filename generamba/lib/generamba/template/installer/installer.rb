module Generamba
  class Installer
    def install_local_template(template_name, local_path)
      full_path = Pathname.new(local_path)
                      .join(template_name + '.rambaspec')
      rambaspec_exist = File.file?(full_path)

      if rambaspec_exist
        puts('The local path is right! Installing template to the current project directory...')
        FileUtils.mkdir_p template_name
        FileUtils.copy_entry(local_path, Pathname.new(template_name))
        puts("Installing is finished! Now you can call: generamba gen #{template_name}")
      end

    end
  end
end