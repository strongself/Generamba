# Generamba 2.0 Roadmap
### Overview

The main aim of 2.0 release is to decouple Generamba from iOS/macOS development and make it available for other areas as well: backend, frontend, Android. 

We'll definitely break the backwards compatibility with *Rambafile* and templates created for the 1.x Generamba versions. To simplify the upgrading process we're considering writing some automatic migration tools.

### High-Level Tasks

* Switch *Rambafile* from `yml` to a custom DSL format.
	* Wrap repetitive tasks into *ramba*'s - the nearest analogs are *lane*'s from `fastlane`.
	* Introduce the concept of two types of *plugins*: system (validation, save) and general-purpose.
	* Allow the usage of different types of hooks - `before`, `after`, `error`.
* Add validation plugins, that are available to check the environment before code generation.
	* Extract the saving logic from the Generamba core to plugins, both to filesystem and Xcode.
* Add saving plugins, that are available to process the text snippet created by generamba and save it somewhere.
	* Extract the validation logic from the Generamba core to plugins, both for CocoaPods and Carthage.

### Generamba Flow

A typical generation process consists of three steps:
	* validation
	* generation
	* saving

#### Validation

That step is used to validate the environment status before code generation. 	It's a perfect place to implement logic of checking the required packages versions, the presence of system libraries, git status and so on.

If one of checks returns an error, the overall validation process doesn't stop until all of validation methods execute. This is crucial for a smooth user experience.

#### Generation

That's the core functionality of Generamba. A user provides a template name and some options which are used as an input. After the generation Generamba produces a text snippet as an output.

There can be multiple generation actions as well. All of them are executed in the writing order and their results are stored in-memory.

#### Saving

This step defines what to do with a generation output. The most obvious options are to store it as a file in some directory on the disk, embed it in your IDE, upload somewhere or print in log.

If there are multiple saving actions, each of them is applied to each generation output. They are executed in the writing order.

### DSL

#### Basic Rambafile Structure

The main building block of *Rambafile* is `ramba`:

```
desc "Creates a new Xcode project"
ramba :viper_module do
  # Detailed description of generation steps
end
```

The *Rambafile* may be monolithic as well as decomposed to multiple files. This is available via special functions:
	- `ramba_import_local('path')` - imports the contents of `Rambafile` stored locally.
	- `ramba_import_git('git', 'branch')` - imports the contents of Rambafile stored in remote git repository.

#### Setting Options

A user can set options in any part of *Rambafile* structure. It's important to note, that option, defined on the next level of method hierarchy, overwrites it's previous declaration. That allows to have a default value for some key and redefine it in each `ramba`.
```
set :project_name, 'MyProject'

ramba :viper_module do
  set :project_name, 'MyProject'
end
```

It's also available to set an option using lambda:
```
set :date_string,  -> { 
	"Current date: #{Date.now}"
}
```

> How options are set in Rambafile...
> 

Besides `ramba` -specific options, there are template-specific options as well. They may correspond to a specific template and be defined in the *.rambaspec* file. 

> The saving action for Xcode should behave differently depending on whether a generated file it's a code file or some resource. So, there is a special option for each file of Xcode templates:
> `- {name: Router/RouterTests.m, path: Tests/Router/router_tests.m.liquid, is_resource: false}` 

#### Hooks

There are multiple types of hooks, which make possible to perform some action or redefine an option in certain moments of generation cycle.

##### `before` hooks

A user can specify a hook, that'll execute before a specific `ramba`:
```
before :viper_module do
	# Some logic here...
end
```

It's also possible to write a hook that'll execute before each `ramba`:
```
before_each do |ramba_name|
	# Some logic here...
end
```

##### `after` hooks

A user can specify a hook, that'll execute after a specific `ramba`:
```
after :viper_module do
	# Some logic here...
end
```

It's also possible to write a hook that'll execute after each `ramba`:
```
after_each do |ramba_name|
	# Some logic here...
end
```

##### `error` hooks

If any action returns an error, it's possible to customize the resulting behavior for a specific `ramba` :
```
error :viper_module do
	# Some logic here...
end
```
It's also possible to write a hook that'll execute in case of error in any `ramba`:
```
error_each do |ramba_name|
	# Some logic here...
end
```

#### `ramba` structure

As we've already mentioned, `ramba` consists of three main steps. Multiple actions in each step are executed in the writing order.

##### Validation actions

```
ramba :viper_module do
	...
	validate :validate_plugin_name do
    set :some_option, 'some_value'
    any_custom_action()
  end
  ...
end
```

This notation means the following steps:
	- The lambda passed to the validate action is executed.
	- The plugin with name `validate_plugin_name` is called with options modified by lambda.

The notation can be simplified to:
```
validate :validate_plugin_name
```	

##### Generation actions

```
ramba :viper_module do
	...
  gen :viper_module do
    set :some_option, 'some_value'
    any_custom_action(parameter1)
 	end
  ...
end
```

This notation means the following steps:
	- The lambda passed to the gen action is executed.
	* The `gen` command is called with a template *viper_module* and options modified by lambda.

The notation can be simplified to:
```
gen :viper_module
```	

##### Saving actions

```
ramba :viper_module do
	...
	save :save_plugin_name do
    set :some_option, 'some_value'
    any_custom_action()
  end
  ...
end
```

This notation means the following steps:
	- The lambda passed to the saving action is executed.
	- The plugin with name `save_plugin_name` is called with options modified by lambda.

The notation can be simplified to:
```
save :save_plugin_name
```	

##### Custom Actions

Besides system plugins (validation and saving), a user can create a general-purpose plugin which contains some specific reusable logic. E.g. a plugin which clears the environment - calls `git reset`, uninstalls some packages and so on. It's called simply by calling it's name:
```
ramba :viper_module do
	...
	any_custom_action()
  ...
end
```

### Plugins

The main ideas behind plugin system are:

	- Increase code reusability between different projects,
	* Keep the Generamba core as simple as possible,
	* Abstract from specific implementations of different IDEs,
	* Allow users to easily extend Generamba functionality for their needs.

As we've already mentioned, there are two types of plugins:

	- System plugins - validation and saving,
	* Custom plugins.

The main difference between them is how system calls them during `ramba` execution.

#### Plugin Structure

```
module Generamba
  module Plugins
		class CocoaPodsPackageVersionValidationPlugin < ValidationPlugin
			# The main body of a plugin
			def self.run(params)
				# Loads Podfile
				# Analyzez dependencies version
				# Compares these versions to the passed options
			end
			
			# The description of what this plugin does
			def self.description
        'Verifies dependencies version in the project Podfile'
      end

			# Explicitly declaring available plugin options
			def self.available_options
        [
          Generamba::ConfigItem.new(key: :package_versions,
                                    description: "The hash with dependencies names and required versions",
                                    default_value: [])
          ]
      end

			# Declaring the output parameters
      def self.output
        [
          ['COCOAPODS_CHECK_RESULT', 'The result of dependency checking']
        ]
      end

			# Who created this plugin
      def self.authors
        ["etolstoy"]
      end
		end
	end
end
```

The same structure applies to other kinds of plugins. The only difference is the base class for the plugin - it can be `ValidationPlugin`, `SavingPlugin`, `Plugin`. 

We've borrowed the plugin structure from `fastlane`.

#### Plugin Distribution

To avoid over-engineering in this version plugins will be distributed together with Generamba binary. If there'll be a lot of community-created plugins, will think about switching to other distribution system.

It's also possible to store plugins near the `Rambafile` in a separate directory `/plugins`. They'll be loaded by Generamba automatically.

### Rambafile Example

```
ramba_import_local('path')
ramba_import_git('git', 'branch')

set :project_name, 'LiveJournal'

before :viper_module do
  set :company, 'Rambler&Co'
  set :xcodeproj_path, 'LiveJournal.xcodeproj'
  set :project_targets, ['LiveJournal1', 'LiveJournal2']
  set :test_target, 'LiveJournalTests'
end

desc "Creates a simple VIPER module"
ramba :viper_module do
  validate :plugin_validate_name do
    set :some_option, '456'
    any_custom_action()
  end

  gen :template_name do
    set :some_option, '123'
    any_custom_action(parameter1)
  end

  save :file_system do
    set :some_option, '789'
  end

  save :xcode_proj
end

desc "Creates a new Xcode project"
ramba :create_project do
  sh("liftoff") # Calling a shell script which invokes a 'liftoff' utility
  add_pods(["Typhoon", "MagicalRecord"])

  gen :app_delegate
  gen :core_data_stack

  save :file_system
  save :xcode_proj
end

# It's called after each 'ramba' execution
after_each do |ramba_name|
  # Some logic here
end

# It's called in case of an error in any 'ramba'
error :viper_module do
  # Some error handling logic here
end
```
