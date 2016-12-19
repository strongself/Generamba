require 'rake'
require 'git'
require 'yaml'

require 'generamba/version'
require 'generamba/errors'

require 'generamba/service/remote_plugin'

require 'generamba/dsl/validators'
require 'generamba/dsl/hooks'
require 'generamba/dsl/attributes'
require 'generamba/dsl/methods'
require 'generamba/dsl/catalogs'
require 'generamba/dsl/templates'

require 'generamba/rake/application'
require 'generamba/rake/dsl'
require 'generamba/rake/rake'
require 'generamba/rake/task'
