require 'liquid'

module Generamba

  # Responsible for generating code using provided liquid templates
	class ContentGenerator

    # Generates and returns a body of a specific code file.
    # @param file []Hash<String,String>] A hashmap with template's filename and filepath
    # @param code_module [CodeModule] The model describing a generating module
    # @param template [ModuleTemplate] The model describing a Generamba template used for code generation
    #
    # @return [String] The generated body
		def self.create_file_content(file, code_module, template)
			file_source = IO.read(template.template_path.join(file[TEMPLATE_FILE_PATH_KEY]))
			Liquid::Template.file_system = Liquid::LocalFileSystem.new(template.template_path.join('snippets'), '%s.liquid')

			template = Liquid::Template.parse(file_source)
			file_name = File.basename(file[TEMPLATE_FILE_NAME_KEY])

			module_info = {
					'name' => code_module.name,
					'file_name' => file_name,
					'description' => code_module.description,
					'project_name' => code_module.project_name,
					'project_targets' => code_module.project_targets,
					'test_targets' => code_module.test_targets
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

			output = template.render(scope)

			return output
		end
	end
end