require 'thor'
require 'xcodeproj'
require 'liquid'
require 'git'
require 'generamba/cli/gen_command.rb'
require 'generamba/cli/setup_command.rb'
require 'generamba/cli/version_command.rb'
require 'generamba/cli/setup_username_command.rb'
require 'generamba/cli/thor_extension.rb'
require 'generamba/cli/template/template_group.rb'

module Generamba::CLI
	class Application < Thor
		
	end
end