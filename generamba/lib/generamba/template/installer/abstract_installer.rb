module Generamba
  class AbstractInstaller
    def install_template(template_declaration)
      raise 'Abstract Method - you should implement it in the concrete subclass'
    end
  end
end