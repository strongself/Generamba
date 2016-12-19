$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'generamba'

RSpec.configure do |config|
  config.before(:each) do
    extend Rake::DSL

    dsl_parent_module = Generamba::DSL

    dsl_parent_module.constants.each do |module_name|
      child_module = dsl_parent_module.const_get(module_name)

      extend child_module if child_module.is_a? Module
    end
  end
end
