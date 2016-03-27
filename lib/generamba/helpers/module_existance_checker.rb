require 'generamba/helpers/paths_generator.rb'

module Generamba

  class ModuleExistanceChecker

    def self.module_exist?(name, code_module, template)

			template.code_files.each do |file|

				file_path = PathsGenerator.generate_file_path(code_module.prefix, name, file[TEMPLATE_NAME_KEY], code_module.module_file_path)

				if File.exist?(file_path)
					return true
				end

			end

			return false
		end

  end

end
