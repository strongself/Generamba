module Generamba
  module DSL
    module Catalogs
      def catalog(link, branch: nil)
        @catalog_link   = link
        @catalog_branch = branch

        generate_install_template_ramba(link, branch)
        load_cashed_templates_information
      end

      private

      def generamba_git
        Generamba::Service::RemotePlugin.new(
          @catalog_link,
          type:   :catalogs,
          branch: @catalog_branch
        )
      end

      def generate_install_template_ramba(link, branch)
        old_task = Rake.application.instance_variable_get('@tasks').delete('template:install')

        namespace :template do
          ramba :install do
            old_task.invoke if old_task
            Generamba::Service::RemotePlugin.new(link, type: :catalogs, branch: branch).sync
          end
        end
      end

      def load_cashed_templates_information
        return unless generamba_git.loaded_plugin?
        load_generamba_temlates_data(generamba_git.cached_plugin_dir)
      end
    end
  end
end

extend Generamba::DSL::Catalogs
