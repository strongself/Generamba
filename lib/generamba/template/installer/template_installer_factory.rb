require 'generamba/template/processor/template_declaration'

module Generamba

  # Factory that creates a proper installer for a given template type
  class TemplateInstallerFactory

    # Provides the appropriate strategy for a given template type
    def installer_for_type(type)
      case type
        when TemplateDeclarationType::LOCAL_TEMPLATE
          return Generamba::LocalInstaller.new
        when TemplateDeclarationType::REMOTE_TEMPLATE
          return Generamba::RemoteInstaller.new
        when TemplateDeclarationType::CATALOG_TEMPLATE
          return Generamba::CatalogInstaller.new
        else
          return nil
      end
    end
  end
end