module Generamba
  class Installer
    def install_local_template(template_name, local_path)
      full_path = Pathname.new(local_path)
                      .join(template_name + '.rambaspec')
      rambaspec_exist = File.file?(full_path)
      
    end
  end
end