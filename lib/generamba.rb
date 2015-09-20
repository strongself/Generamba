require "generamba/version"
require "file_generator.rb"
require "cli.rb"
require "xcode_injector.rb"

module Generamba
  # Your code goes here...
end

Generamba::CLI::Application.start(ARGV)