require 'liquid'

module Generamba

  # Responsible for generating code using provided liquid templates
	class ContentGenerator

    # Generates and returns a filename and a body of a specific code file.
    # @param file [Hash<String,String>] A hashmap with template's filename and filepath
    # @param scope [Hash<String,String>] A hashmap with module info
    # @param template [ModuleTemplate] The model describing a Generamba template used for code generation
    #
    # @return [String], [String] The generated file_name and body
		def self.create_file(file, scope, template)
			file_source = IO.read(template.template_path.join(file[TEMPLATE_FILE_PATH_KEY]))
			Liquid::Template.file_system = Liquid::LocalFileSystem.new(template.template_path.join('snippets'), '%s.liquid')

			template = Liquid::Template.parse(file_source)
			filename_template = self.file_name_template(file)
      
			file_basename = File.basename(file[TEMPLATE_FILE_NAME_KEY])

			module_info = scope['module_info']
			
			module_info['file_basename'] = file_basename

			file_name = filename_template.render(scope)

			module_info['file_name'] = file_name
			module_info.delete('file_basename')

			content = template.render(scope)

			return file_name, content
		end
    
		def self.file_name_template(file)
			template_default_text = '{{ prefix }}{{ module_info.name }}{{ module_info.file_basename }}'
			template_text = file[TEMPLATE_FILE_CUSTOM_NAME_KEY] || template_default_text
			return Liquid::Template.parse(template_text)
		end
	end
end
