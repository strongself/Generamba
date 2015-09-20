require 'thor'

module Generamba::CLI
	class Application < Thor
	  desc "generate NAME", "generates brand new viper module with NAME"
	  def self.generate(name)
	    Generamba::FileGenerator.new.createModule
	  end
	end
end