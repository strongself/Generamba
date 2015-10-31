require 'thor'
require 'xcodeproj'
require 'liquid'
require 'tilt'

module Generamba::CLI
	class Application < Thor

	  desc 'gen MODULE_NAME', 'Creates a new VIPER module with a given name'
		method_option :template, :aliases => '-t', :desc => 'Provides a name for the template to be used'
	  method_option :description, :aliases => '-d', :desc => 'Provides a full description to the module'
	  def gen(module_name)
        does_rambafile_exist = Dir['Rambafile'].count > 0

        if (does_rambafile_exist == false)
          puts('Rambafile not found! Run `generamba setup` in the working directory instead!')
          return
        end

      	module_description = options[:description] ? options[:description] : 'Sample Description'
				template_name = options[:template] ? options[:template] : 'viper_module'

      	generator = Generamba::ModuleGenerator.new()
      	generator.generate_module(template_name, module_name, module_description)
		end

		desc 'setup', 'Creates a Rambafile with a config for a given project'
		def setup
			properties = {}

			git_username = Git.init.config['user.name']

			if git_username != nil
				is_right_name = yes?("Your name in git is configured as #{git_username}. Do you want to use it in code headers? (yes/no)")
				properties['author_name'] = is_right_name ? git_username : ask('The author name which will be used in the headers:')
			else
				properties['author_name'] = ask('The author name which will be used in the headers:')
			end

			properties['author_company'] = ask('The company name which will be used in the headers')

			project_name = Pathname.new(Dir.getwd).basename.to_s
			is_right_project_name = yes?("The name of your project is #{project_name}. Do you want to use it? (yes/no)")
			properties['project_name'] = is_right_project_name ? project_name : ask('The project name:')

			properties['prefix']  = ask('The project prefix (if any):')

      project_files = Dir['*.xcodeproj']
      count = project_files.count
      if count == 1
        is_right_path = yes?("The path to a .xcodeproj file of the project is #{project_files[0]}. Do you want to use it? (yes/no)")
				xcode_path = is_right_path ? File.absolute_path(project_files[0]) : ask('The path to a .xcodeproj file of the project:')
      else
				xcode_path = ask('The path to a .xcodeproj file of the project:')
			end

			properties['xcodeproj_path'] = xcode_path
			project = Xcodeproj::Project.open(xcode_path)

			targets_prompt = ''
			project.targets.each_with_index { |element, i| targets_prompt += ("#{i}. #{element.name}" + "\n") }

			project_target_index = ask("Select the appropriate target for adding your modules (print the index):\n" + targets_prompt)
			project_target = project.targets[project_target_index.to_i]

			test_target_index = ask("Select the appropriate target for adding your tests (print the index):\n" + targets_prompt)
			test_target = project.targets[test_target_index.to_i]

			project_group_path = ask('The default group path for creating new modules:')
			project_file_path = ask('The default file path for creating new modules:')

			test_group_path = ask('The default group path for creating tests:')
			test_file_path = ask('The default file path for creating tests:')

			template = Tilt.new(File.dirname(__FILE__) + '/Rambafile.liquid')
			properties['project_target'] = project_target.name
			properties['project_file_path'] = project_file_path
			properties['project_group_path'] = project_group_path
			properties['test_target'] = test_target.name
			properties['test_file_path'] = test_file_path
			properties['test_group_path'] = test_group_path
			output = template.render(properties)

			File.open('Rambafile', 'w+') {|f|
				f.write(output)
			}
		end
	end
end