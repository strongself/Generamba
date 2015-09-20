#!/usr/bin/ruby

require 'liquid'
require 'tilt'

class Generamba::FileGenerator
	def initialize
	end

	def createModule
		# 1. Create a new model object (name, description, file_path, group_path)
		# 2. Load a proper Rambafile with config
		# 3. Generate a scope hashtable from Rambafile and model object
		# 4. Create new files
		# 5. Add files to a given xcodeproj.file (maybe take the path from Rambafile)

		template = Tilt.new(File.dirname(__FILE__) + '/templates/assembly.m.liquid')

		module_info = {}
		module_info['name'] = "Test Module"
		module_info['fileName'] = "TestModule"
		module_info['description'] = "Test module to test scripts"
		module_info['viewType'] = "Controller"

		developer = { 'name' => "Andrey Zarembo",'company' => "Rambler & Co" }

		scope = { 'year' => '2015', 'date' => '12.12.2015', 'developer' => developer, 'module_info' => module_info,'prefix' => 'RCM' }

		print(template.render(scope))
	end
end