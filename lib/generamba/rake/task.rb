module Rake
  class Task
    alias old_execute execute

    def execute(args = nil)
      Rake.application.current_task = @name

      before_hooks.each(&:call)

      old_execute(args)

      after_hooks.each(&:call)
    rescue
      error_hooks.each(&:call)
      raise
    end

    private

    def error_hooks
      error_hooks     = Rake.application.error_hooks[@name]        || []
      error_all_hooks = Rake.application.error_hooks['error_all']  || []

      error_all_hooks | error_hooks
    end

    def before_hooks
      before_hooks     = Rake.application.before_hooks[@name]        || []
      before_all_hooks = Rake.application.before_hooks['before_all'] || []

      before_all_hooks | before_hooks
    end

    def after_hooks
      after_hooks     = Rake.application.after_hooks[@name]       || []
      after_all_hooks = Rake.application.after_hooks['after_all'] || []

      after_all_hooks | after_hooks
    end
  end
end
