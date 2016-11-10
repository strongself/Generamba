class RambaApplication < Rake::Application
  attr_accessor :current_task, :before_hooks, :after_hooks, :error_hooks

  def initialize
    super
    @rakefiles = DEFAULT_RAKEFILES.dup << 'Rambafile'
    @before_hooks = {}
    @after_hooks  = {}
    @error_hooks  = {}
  end

  def standard_rake_options
    [[
      '--version', '-V',
      'Display the program version.',
      lambda do |_|
        puts "ramba, version v.#{Generamba::VERSION}"
        exit
      end
    ]]
  end
end
