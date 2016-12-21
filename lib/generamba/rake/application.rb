class RambaApplication < Rake::Application
  attr_accessor :current_task
  attr_accessor :before_hooks, :after_hooks, :error_hooks
  attr_accessor :raw_templates_list, :selected_templates

  def initialize
    super
    @rakefiles = DEFAULT_RAKEFILES.dup << 'Rambafile'
    @before_hooks        = {}
    @after_hooks         = {}
    @error_hooks         = {}
    @raw_templates_list  = {}
    @selected_templates  = {}
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
