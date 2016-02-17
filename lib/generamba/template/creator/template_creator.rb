module Generamba

  # Responsible for generating new .rambaspec files
  class TemplateCreator

    NEW_TEMPLATE_FOLDER = 'new_template'
    RAMBASPEC_TEMPLATE_NAME = 'template.rambaspec.liquid'
    CODE_FOLDER = 'Code'
    TESTS_FOLDER = 'Tests'

    # Generates and saves to filesystem a new template with a .rambaspec file and sample code and tests files
    # @param properties [Hash] User-inputted template properties
    #
    # @return [Void]
    def create_template(properties)
      template_dir_path = Pathname.new(File.dirname(__FILE__)).join(NEW_TEMPLATE_FOLDER)
      rambaspec_template_file_path = template_dir_path.join(RAMBASPEC_TEMPLATE_NAME)
      code_file_path = template_dir_path.join(CODE_FOLDER)
      tests_file_path = template_dir_path.join(TESTS_FOLDER)

      file_source = IO.read(rambaspec_template_file_path)

      template = Liquid::Template.parse(file_source)
      output = template.render(properties)

      result_name = properties[TEMPLATE_NAME_KEY] + RAMBASPEC_EXTENSION
      result_dir_path = Pathname.new(properties[TEMPLATE_NAME_KEY])

      FileUtils.mkdir_p result_dir_path
      FileUtils.cp_r(code_file_path, result_dir_path)
      FileUtils.cp_r(tests_file_path, result_dir_path)

      File.open(result_dir_path.join(result_name), 'w+') {|f|
        f.write(output)
      }
    end

  end
end