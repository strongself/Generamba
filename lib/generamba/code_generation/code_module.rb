module Generamba

  SLASH_REGEX = /^\/|\/$/
  C99IDENTIFIER = /[^\w]/
  
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
                :module_file_path,
                :module_group_path,
                :test_file_path,
                :test_group_path,
                :project_targets,
                :test_targets,
                :podfile_path,
                :cartfile_path,
                :custom_parameters

    def initialize(name, description, rambafile, options)
      # Base initialization
      @name = name
      @description = description

      if rambafile[AUTHOR_NAME_KEY] != nil
        @author = rambafile[AUTHOR_NAME_KEY]
      else
        @author = UserPreferences.obtain_username
      end

      @company = rambafile[COMPANY_KEY]
      @year = Time.now.year.to_s

      @prefix = rambafile[PROJECT_PREFIX_KEY]
      @project_name = rambafile[PROJECT_NAME_KEY]
      @product_module_name = rambafile[PRODUCT_MODULE_NAME_KEY] || @project_name.gsub(C99IDENTIFIER, '_')
      @xcodeproj_path = rambafile[XCODEPROJ_PATH_KEY]

      @module_file_path = rambafile[PROJECT_FILE_PATH_KEY].gsub(SLASH_REGEX, '')
      @module_file_path = Pathname.new(@module_file_path).join(@name)

      @module_group_path = rambafile[PROJECT_GROUP_PATH_KEY].gsub(SLASH_REGEX, '')
      @module_group_path = Pathname.new(@module_group_path).join(@name)

      if rambafile[TEST_FILE_PATH_KEY] != nil
        @test_file_path = rambafile[TEST_FILE_PATH_KEY].gsub(SLASH_REGEX, '')
        @test_file_path = Pathname.new(@test_file_path).join(@name)
      end

      if rambafile[TEST_GROUP_PATH_KEY] != nil
        @test_group_path = rambafile[TEST_GROUP_PATH_KEY].gsub(SLASH_REGEX, '')
        @test_group_path = Pathname.new(@test_group_path).join(@name)
      end

      @project_targets = [rambafile[PROJECT_TARGET_KEY]] if rambafile[PROJECT_TARGET_KEY] != nil
      @project_targets = rambafile[PROJECT_TARGETS_KEY] if rambafile[PROJECT_TARGETS_KEY] != nil

      @test_targets = [rambafile[TEST_TARGET_KEY]] if rambafile[TEST_TARGET_KEY] != nil
      @test_targets = rambafile[TEST_TARGETS_KEY] if rambafile[TEST_TARGETS_KEY] != nil

      # Custom parameters
      @custom_parameters = options[:custom_parameters]

      # Options adaptation
      @author = options[:author] if options[:author]
      @project_targets = options[:project_targets].split(',') if options[:project_targets]
      @test_targets = options[:test_targets].split(',') if options[:test_targets]

      if options[:module_file_path]
        @module_file_path = options[:module_file_path].gsub(SLASH_REGEX, '')
        @module_file_path = Pathname.new(@module_file_path).join(@name)
      end

      if options[:module_group_path]
        @module_group_path = options[:module_group_path].gsub(SLASH_REGEX, '')
        @module_group_path = Pathname.new(@module_group_path).join(@name)
      end

      if options[:test_file_path]
        @test_file_path = options[:test_file_path].gsub(SLASH_REGEX, '')
        @test_file_path = Pathname.new(@test_file_path).join(@name)
      end

      if options[:test_group_path]
        @test_group_path = options[:test_group_path].gsub(SLASH_REGEX, '')
        @test_group_path = Pathname.new(@test_group_path).join(@name)
      end

      # The priority is given to `module_path` and 'test_path' options
      if options[:module_path]
        @module_path = options[:module_path].gsub(SLASH_REGEX, '')
        @module_file_path = Pathname.new(@module_path).join(@name)
        @module_group_path = Pathname.new(@module_path).join(@name)
      end

      if options[:test_path]
        @test_path = options[:test_path].gsub(SLASH_REGEX, '')
        @test_file_path = Pathname.new(@test_path).join(@name)
        @test_group_path = Pathname.new(@test_path).join(@name)
      end

      @podfile_path = rambafile[PODFILE_PATH_KEY] if rambafile[PODFILE_PATH_KEY] != nil
      @cartfile_path = rambafile[CARTFILE_PATH_KEY] if rambafile[CARTFILE_PATH_KEY] != nil
    end

  end
end
