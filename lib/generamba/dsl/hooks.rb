module Generamba
  module DSL
    module Hooks
      def error(*task_names, &new_task)
        task_names.each do |task_name|
          hooks = Rake.application.error_hooks[task_name.to_s] || []
          hooks << new_task

          Rake.application.error_hooks[task_name.to_s] = hooks
        end
      end

      def error_each(&new_task)
        error :error_all, &new_task
      end

      def before(*task_names, &new_task)
        task_names.each do |task_name|
          hooks = Rake.application.before_hooks[task_name.to_s] || []
          hooks << new_task

          Rake.application.before_hooks[task_name.to_s] = hooks
        end
      end

      def before_each(&new_task)
        before :before_all, &new_task
      end

      def after(*task_names, &new_task)
        task_names.each do |task_name|
          hooks = Rake.application.after_hooks[task_name.to_s] || []
          hooks << new_task

          Rake.application.after_hooks[task_name.to_s] = hooks
        end
      end

      def after_each(&new_task)
        after :after_all, &new_task
      end
    end
  end
end

extend Generamba::DSL::Hooks
