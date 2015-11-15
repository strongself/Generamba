require 'xcodeproj'

module Generamba
  require 'generamba/constants/constants.rb'
  require 'generamba/constants/rambafile_constants.rb'
  require 'generamba/constants/rambaspec_constants.rb'
  require 'generamba/cli/cli.rb'
  require 'generamba/code_generation/code_module.rb'
  require 'generamba/code_generation/module_template.rb'
  require 'generamba/configuration/project_configuration'
  require 'generamba/code_generation/content_generator.rb'
  require 'generamba/code_generation/rambafile_generator.rb'
  require 'generamba/module_generator.rb'
  require 'generamba/template/processor/template_processor.rb'
  require 'generamba/configuration/user_preferences.rb'
  require 'generamba/template/creator/template_creator.rb'
end