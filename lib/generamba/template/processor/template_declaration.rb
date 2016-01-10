module Generamba

  # This class acts as an Enumeration for TemplateDeclaration types
  class TemplateDeclarationType
    # A local template - usually it's stored somewhere outside the current project directory
    LOCAL_TEMPLATE = 0

    # A remote template - it's stored in a remote Git repository
    REMOTE_TEMPLATE = 1

    # A template from our shared catalog
    CATALOG_TEMPLATE = 2
  end

  # Describes a Generamba template declaration model
  class TemplateDeclaration

    attr_reader :name, :local, :git, :type

    def initialize(template_hash)
      @name = template_hash[TEMPLATE_DECLARATION_NAME_KEY]
      @local = template_hash[TEMPLATE_DECLARATION_LOCAL_KEY]
      @git = template_hash[TEMPLATE_DECLARATION_GIT_KEY]

      @type = TemplateDeclarationType::LOCAL_TEMPLATE if @local
      @type = TemplateDeclarationType::REMOTE_TEMPLATE if @git
      @type = TemplateDeclarationType::CATALOG_TEMPLATE if @git == nil && @local == nil
    end

    def install(strategy)
      strategy.install_template(self)
    end

  end
end