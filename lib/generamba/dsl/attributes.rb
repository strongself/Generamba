module Generamba
  module DSL
    module Attributes
      def set(variable_name, variable_value)
        options_value = { variable_name => variable_value }
        ramba_options.merge!(options_key => options_value)
      end

      def get(variable_name)
        value = ramba_options.fetch(options_key, nil).fetch(variable_name, nil)
        value ||= ramba_options.fetch(:global, nil).fetch(variable_name, nil)

        return value.call if value.is_a?(Proc)
        value
      end

      private

      def options_key
        (Rake.application.current_task || :global).to_sym
      end

      def ramba_options
        @ramba_options ||= {}
      end
    end
  end
end

extend Generamba::DSL::Attributes
