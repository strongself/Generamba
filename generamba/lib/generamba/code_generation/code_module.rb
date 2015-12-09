module Generamba

  # Represents currently generating code module
  class CodeModule
    attr_reader :name, :description, :module_file_path, :module_group_path, :test_file_path, :test_group_path

    def initialize(name, description, options)
      @name = name
      @description = description

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

    def author
      Generamba::UserPreferences.obtain_username
    end

    def company
      ProjectConfiguration.company
    end

    def year
      Time.now.year.to_s
    end

    def prefix
      ProjectConfiguration.prefix
    end

    def project_name
      ProjectConfiguration.project_name
    end

    def module_file_path
      return @module_file_path != nil ?
          @module_file_path :
          Pathname.new(ProjectConfiguration.project_file_path)
              .join(@name)
    end

    def module_group_path
      return @module_group_path != nil ?
          @module_group_path :
          Pathname.new(ProjectConfiguration.project_group_path)
              .join(@name)
    end

    def test_file_path
      return @test_file_path != nil ?
          @test_file_path :
          Pathname.new(ProjectConfiguration.test_file_path)
              .join(@name)
    end

    def test_group_path
      return @test_group_path != nil ?
          @test_group_path :
          Pathname.new(ProjectConfiguration.test_group_path)
              .join(@name)
    end

  end
end