module Generamba

  # Represents currently generating code module
  class CodeModule
    attr_reader :name,
                :description,
                :author,
                :company,
                :year,
                :prefix,
                :project_name,
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
      @xcodeproj_path = rambafile[XCODEPROJ_PATH_KEY]

      @module_file_path = Pathname.new(rambafile[PROJECT_FILE_PATH_KEY]).join(@name)
      @module_group_path = Pathname.new(rambafile[PROJECT_GROUP_PATH_KEY]).join(@name)

      @test_file_path = Pathname.new(rambafile[TEST_FILE_PATH_KEY]).join(@name) if rambafile[TEST_FILE_PATH_KEY] != nil
      @test_group_path = Pathname.new(rambafile[TEST_GROUP_PATH_KEY]).join(@name) if rambafile[TEST_GROUP_PATH_KEY] != nil

      @project_targets = [rambafile[PROJECT_TARGET_KEY]] if rambafile[PROJECT_TARGET_KEY] != nil
      @project_targets = rambafile[PROJECT_TARGETS_KEY] if rambafile[PROJECT_TARGETS_KEY] != nil

      @test_targets = [rambafile[TEST_TARGET_KEY]] if rambafile[TEST_TARGET_KEY] != nil
      @test_targets = rambafile[TEST_TARGETS_KEY] if rambafile[TEST_TARGETS_KEY] != nil

      # Custom parameters
      @custom_parameters = options[:custom_parameters]

      # Options adaptation
      @author = options[:author] if options[:author]
      @project_targets = options[:module_targets].split(',') if options[:module_targets]
      @test_targets = options[:test_targets].split(',') if options[:test_targets]

      @module_file_path = Pathname.new(options[:module_file_path]).join(@name) if options[:module_file_path]
      @module_group_path = Pathname.new(options[:module_group_path]).join(@name) if options[:module_group_path]
      @test_file_path = Pathname.new(options[:test_file_path]).join(@name) if options[:test_file_path]
      @test_group_path = Pathname.new(options[:test_group_path]).join(@name) if options[:test_group_path]

      # The priority is given to `module_path` and 'test_path' options
      @module_file_path = Pathname.new(options[:module_path]).join(@name) if options[:module_path]
      @module_group_path = Pathname.new(options[:module_path]).join(@name) if options[:module_path]
      @test_file_path = Pathname.new(options[:test_path]).join(@name) if options[:test_path]
      @test_group_path = Pathname.new(options[:test_path]).join(@name) if options[:test_path]

      @podfile_path = rambafile[PODFILE_PATH_KEY] if rambafile[PODFILE_PATH_KEY] != nil
      @cartfile_path = rambafile[CARTFILE_PATH_KEY] if rambafile[CARTFILE_PATH_KEY] != nil
    end
  end
end