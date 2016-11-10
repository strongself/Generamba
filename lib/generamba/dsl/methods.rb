module Generamba
  module DSL
    module Methods
      def invoke(task_name)
        Rake::Task[task_name].invoke
      end

      def sh(command_string)
        `#{command_string}`.split("\n")
      end
    end
  end
end

extend Generamba::DSL::Methods
