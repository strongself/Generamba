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
                :module_file_path,
                :module_group_path,
                :test_file_path,
                :test_group_path,
                :project_targets,
                :test_targets

    def initialize(name, description, rambafile, options)
      # Base initialization
      @name = name
      @description = description

      @author = UserPreferences.obtain_username
      @company = rambafile[COMPANY_KEY]
      @year = Time.now.year.to_s

      @prefix = rambafile[PROJECT_PREFIX_KEY]
      @project_name = rambafile[PROJECT_NAME_KEY]

      @module_file_path = Pathname.new(rambafile[PROJECT_FILE_PATH_KEY]).join(@name)
      @module_group_path = Pathname.new(rambafile[PROJECT_GROUP_PATH_KEY]).join(@name)

      @test_file_path = Pathname.new(rambafile[TEST_FILE_PATH_KEY]).join(@name) if rambafile[TEST_FILE_PATH_KEY] != nil
      @test_group_path = Pathname.new(rambafile[TEST_GROUP_PATH_KEY]).join(@name) if rambafile[TEST_GROUP_PATH_KEY] != nil

      @project_targets = [rambafile[PROJECT_TARGET_KEY]] if rambafile[PROJECT_TARGET_KEY] != nil
      @project_targets = rambafile[PROJECT_TARGETS_KEY] if rambafile[PROJECT_TARGETS_KEY] != nil

      @test_targets = [rambafile[TEST_TARGET_KEY]] if rambafile[TEST_TARGET_KEY] != nil
      @test_targets = rambafile[TEST_TARGETS_KEY] if rambafile[TEST_TARGETS_KEY] != nil

      # Options adaptation
      @project_targets = options[:module_targets].split(',') if options[:module_targets]
      @test_targets = options[:test_targets].split(',') if options[:test_targets]

      @module_file_path = Pathname.new(options[:module_file_path]) if options[:module_file_path]
      @module_group_path = Pathname.new(options[:module_group_path]) if options[:module_group_path]
      @test_file_path = Pathname.new(options[:test_file_path]) if options[:test_file_path]
      @test_group_path = Pathname.new(options[:test_group_path]) if options[:test_group_path]

      # The priority is given to `module_path` and 'test_path' options
      @module_file_path = Pathname.new(options[:module_path]) if options[:module_path]
      @module_group_path = Pathname.new(options[:module_path]) if options[:module_path]
      @test_file_path = Pathname.new(options[:test_path]) if options[:test_path]
      @test_group_path = Pathname.new(options[:test_path]) if options[:test_path]
    end
  end
end