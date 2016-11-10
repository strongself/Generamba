$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'generamba'

RSpec.configure do |config|
  config.before(:each) do
    extend Rake::DSL
    extend Generamba::DSL::Attributes
    extend Generamba::DSL::Hooks
    extend Generamba::DSL::Methods
    extend Generamba::DSL::Validators
  end
end
