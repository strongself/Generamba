require "generamba/version"
require "file_generator.rb"
require "cli.rb"
require "xcode_injector.rb"
require "viper_module.rb"
require "viper_module_processor.rb"

module Generamba
  # Your code goes here...
end

Generamba::CLI::Application.start(ARGV)