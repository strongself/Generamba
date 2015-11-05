module Generamba
  class TemplateDeclarationType
    LOCAL_TEMPLATE = 0
    REMOTE_TEMPLATE = 1
  end

  class TemplateDeclaration
    attr_reader :name, :local, :git, :type

    def initialize(template_hash)
      @name = template_hash['name']
      @local = template_hash['local']
      @git = template_hash['git']

      @type = TemplateDeclarationType::LOCAL_TEMPLATE if @local
      @type = TemplateDeclarationType::REMOTE_TEMPLATE if @git
    end

    def install(strategy)
      strategy.install_template(self)
    end

  end
end