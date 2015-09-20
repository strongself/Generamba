#!/usr/bin/ruby

require 'liquid'
require 'tilt'

class Generamba::FileGenerator
	def initialize
	end

	def createModule
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