module Generamba

  SLASH_REGEX = /^\/|\/$/
  C99IDENTIFIER = /[^\w]/

  PATH_TYPE_PROJECT = 'project'
  PATH_TYPE_TEST = 'test'

  # Represents currently generating code module
  class CodeModule
    attr_reader :name,
                :description,
                :author,
                :company,
                :year,
                :prefix,
                :project_name,
                :product_module_name,
                :xcodeproj_path,
                :project_file_path,
                :project_group_path,
                :test_file_path,
                :test_group_path,
                :project_targets,
                :test_targets,
                :podfile_path,
                :cartfile_path,
                :custom_parameters,
                :create_logical_groups

    def initialize(name, rambafile, options)
      # Base initialization
      @name = name
      @description = options[:description] ? options[:description] : "#{name} module"
      @author = rambafile[AUTHOR_NAME_KEY] ? rambafile[AUTHOR_NAME_KEY] : UserPreferences.obtain_username
      @company = rambafile[COMPANY_KEY]
      @year = Time.now.year.to_s

      @prefix = rambafile[PROJECT_PREFIX_KEY]
      @project_name = rambafile[PROJECT_NAME_KEY]

      @product_module_name = rambafile[PRODUCT_MODULE_NAME_KEY]
      @product_module_name = @project_name.gsub(C99IDENTIFIER, '_') if !@product_module_name && @project_name

      @xcodeproj_path = rambafile[XCODEPROJ_PATH_KEY]

      setup_file_and_group_paths(rambafile[PROJECT_FILE_PATH_KEY], rambafile[PROJECT_GROUP_PATH_KEY], PATH_TYPE_PROJECT)
      setup_file_and_group_paths(rambafile[TEST_FILE_PATH_KEY], rambafile[TEST_GROUP_PATH_KEY], PATH_TYPE_TEST)

      @project_targets = [rambafile[PROJECT_TARGET_KEY]] if rambafile[PROJECT_TARGET_KEY]
      @project_targets = rambafile[PROJECT_TARGETS_KEY] if rambafile[PROJECT_TARGETS_KEY]

      @test_targets = [rambafile[TEST_TARGET_KEY]] if rambafile[TEST_TARGET_KEY]
      @test_targets = rambafile[TEST_TARGETS_KEY] if rambafile[TEST_TARGETS_KEY]

      # Custom parameters
      @custom_parameters = options[:custom_parameters]

      # Options adaptation
      @author = options[:author] if options[:author]
      @project_targets = options[:project_targets].split(',') if options[:project_targets]
      @test_targets = options[:test_targets].split(',') if options[:test_targets]
      
      setup_file_and_group_paths(options[:project_file_path], options[:project_group_path], PATH_TYPE_PROJECT)
      setup_file_and_group_paths(options[:test_file_path], options[:test_group_path], PATH_TYPE_TEST)

      # The priority is given to `module_path` and 'test_path' options
      setup_file_and_group_paths(options[:module_path], options[:module_path], PATH_TYPE_PROJECT)
      setup_file_and_group_paths(options[:test_path], options[:test_path], PATH_TYPE_TEST)

      @podfile_path = rambafile[PODFILE_PATH_KEY] if rambafile[PODFILE_PATH_KEY]
      @cartfile_path = rambafile[CARTFILE_PATH_KEY] if rambafile[CARTFILE_PATH_KEY]
      @create_logical_groups = rambafile[CREATE_LOGICAL_GROUPS_KEY] if rambafile[CREATE_LOGICAL_GROUPS_KEY]
    end

    private

    def setup_file_and_group_paths(file_path, group_path, path_type)
      if file_path || group_path
        variable_name = "#{path_type}_file_path"

        if file_path || !instance_variable_get("@#{variable_name}")
          file_path = group_path unless file_path

          variable_value = file_path.gsub(SLASH_REGEX, '')
          variable_value = Pathname.new(variable_value).join(@name)
          instance_variable_set("@#{variable_name}", variable_value)
        end

        variable_name = "#{path_type}_group_path"

        if group_path || !instance_variable_get("@#{variable_name}")
          group_path = file_path unless group_path

          variable_value = group_path.gsub(SLASH_REGEX, '')
          variable_value = Pathname.new(variable_value).join(@name)
          instance_variable_set("@#{variable_name}", variable_value)
        end
      end
    end
  end
end
