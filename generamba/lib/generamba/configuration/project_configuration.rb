require 'settingslogic'

module Generamba

  # A singletone class representing a Rambafile of the current project
  class ProjectConfiguration < Settingslogic
    source Dir.getwd + '/' + RAMBAFILE_NAME
  end
end