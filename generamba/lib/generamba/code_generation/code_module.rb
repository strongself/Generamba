module Generamba

  # Represents currently generating code module
  class CodeModule
    attr_reader :name,
                :description,
                :module_file_path,
                :module_group_path,
                :test_file_path,
                :test_group_path,
                :project_targets,
                :test_targets

    def initialize(name, description, options)
      @name = name
      @description = description

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
      if @test_file_path == nil
        if ProjectConfiguration.test_file_path == nil
          return nil
        end

        return Pathname.new(ProjectConfiguration.test_file_path)
                   .join(@name)
      end
      return @test_file_path
    end

    def test_group_path
      if @test_group_path == nil
        if ProjectConfiguration.test_group_path == nil
          return nil
        end

        return Pathname.new(ProjectConfiguration.test_group_path)
                   .join(@name)
      end
      return @test_group_path
    end

    def project_targets
      targets = Array.new
      if ProjectConfiguration.project_target != nil
        targets = [ProjectConfiguration.project_target]
      end

      if ProjectConfiguration.project_targets != nil
        targets = ProjectConfiguration.project_targets
      end

      if @project_targets != nil
        targets = @project_targets
      end

      return targets
    end

    def test_targets
      targets = Array.new
      if ProjectConfiguration.test_target != nil
        targets = [ProjectConfiguration.test_target]
      end

      if ProjectConfiguration.test_targets != nil
        targets = ProjectConfiguration.test_targets
      end

      if @test_targets != nil
        targets = @test_targets
      end

      return targets
    end
  end
end