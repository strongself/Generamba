module Generamba
  module DSL
    module Templates
      def template(template_name, options = {})
        locale_path = options[:path]
        load_generamba_temlates_data(locale_path) if locale_path

        templates = take_downloaded_generamba_templates(template_name, options)

        prepare_template_to_use(template_name, templates)
      end

      def load_generamba_temlates_data(path)
        specs = Dir.glob("#{path}/**/*.rambaspec")
        raise Generamba::Error::IncorrectRepository if specs.empty?

        specs.each do |spec_file|
          spec_source      = YAML.load_file(spec_file)
          spec_directory   = File.dirname(spec_file)
          parsed_rambaspec = parse_rambaspec_file(spec_source, spec_directory)

          Rake.application.raw_templates_list.merge!(parsed_rambaspec)
        end
      end

      private

      def take_downloaded_generamba_templates(template_name, options)
        versions_template = Rake.application.raw_templates_list[template_name.to_s]
        raise Generamba::Error::UndefinedTemplateName if versions_template.nil?

        version = options[:version] || versions_template.keys.sort.last
        templates = versions_template[version.to_s]

        raise Generamba::Error::UndefinedTemplateVersion if templates.nil?
        templates
      end

      def prepare_template_to_use(template_name, templates)
        Rake.application.selected_templates.merge!(template_name => templates)
      end

      def parse_rambaspec_file(spec_source, spec_directory)
        name    = spec_source.fetch('name')
        version = spec_source.fetch('version')

        raw_files_list = [
          *spec_source['code_files'],
          *spec_source['test_files'],
          *spec_source['files']
        ]

        files_list = raw_files_list.map do |file_hash|
          {
            target:           file_hash.fetch('name'),
            source_full_path: "#{spec_directory}/#{file_hash.fetch('path')}"
          }
        end

        { name => { version => files_list } }
      end
    end
  end
end

extend Generamba::DSL::Templates
