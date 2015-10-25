#!/usr/bin/ruby

require 'liquid'
require 'tilt'

class Generamba::FileContentGenerator
	def initialize
	end

	def create_element(template_path, module_name, module_description, file_name, configuration)
		template = Tilt.new(Dir.getwd + '/' + template_path)
		module_info = {
				'name' => module_name,
				'file_name' => file_name,
				'description' => module_description
		}

		developer = {
				'name' => configuration.author,
				'company' => configuration.company
		}

		scope = {
				'year' => configuration.year,
				'date' => Time.now.strftime("%d/%m/%Y"),
				'developer' => developer,
				'module_info' => module_info,
				'prefix' => configuration.prefix
		}

		output = template.render(scope)
		return output
	end
end