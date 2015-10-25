require 'settingslogic'

module Generamba
  class ProjectConfiguration < Settingslogic
    source Dir.getwd + '/Rambafile'
  end
end