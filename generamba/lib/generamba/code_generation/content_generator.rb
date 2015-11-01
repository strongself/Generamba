require 'liquid'
require 'tilt'

module Generamba

  # Responsible for generating code using provided liquid templates
	class ContentGenerator

    # Generates and returns a body of a specific code file.
    # @param file []Hash<String,String>] A hashmap with template's filename and filepath
    # @param code_module [CodeModule] The model describing a generating module
    # @param template [ModuleTemplate] The model sescriving a Generamba template used for code generation
    #
    # @return [String] The generated body
		def self.create_file_content(file, code_module, template)
			file_template = Tilt.new(template.template_path.join(file['path']))
      file_name = File.basename(file['name'])
			module_info = {
					'name' => code_module.name,
					'file_name' => file_name,
					'description' => code_module.description,
          'project_name' => code_module.project_name
			}

			developer = {
					'name' => code_module.author,
					'company' => code_module.company
			}

			scope = {
					'year' => code_module.year,
					'date' => Time.now.strftime('%d/%m/%Y'),
					'developer' => developer,
					'module_info' => module_info,
					'prefix' => code_module.prefix
			}

			output = file_template.render(scope)
			return output
		end
	end
end