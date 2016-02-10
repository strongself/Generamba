require 'generamba/helpers/print_table.rb'

module Generamba::CLI
  class Template < Thor
    include Generamba

    desc 'create [TEMPLATE_NAME]', 'Creates a new Generamba template with a given name'
    def create(template_name)
      summary = ask('The brief description of your new template:')
      author = ask('Who is the author of this template:')
      license = ask('What license will be used (e.g. MIT):')

      has_dependencies = yes?('Will your template contain any third-party dependencies (available via Cocoapods or Carthage)? (yes/no)')
      if has_dependencies
        dependencies = ask_loop('Enter the name of your dependency (empty string to stop):')
      end

      properties = {
          TEMPLATE_NAME_KEY => template_name,
          TEMPLATE_SUMMARY_KEY => summary,
          TEMPLATE_AUTHOR_KEY => author,
          TEMPLATE_LICENSE_KEY => license
      }

      if dependencies and !dependencies.empty?
        properties[TEMPLATE_DEPENDENCIES_KEY] = dependencies
      end

      PrintTable.print_values(
          values: properties,
          title: "Summary for template create"
      )

      template_creator = Generamba::TemplateCreator.new
      template_creator.create_template(properties)
      puts("The template #{template_name} is successfully generated! Now add some file templates into it.".green)
    end

  end
end