module Generamba

  # Represents currently generating code module
  class CodeModule
    attr_reader :name, :description
    attr_accessor :project_file_path, :project_group_path, :test_file_path, :test_group_path

    def initialize(name, description)
      @name = name
      @description = description
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

    def project_file_path
      return @project_file_path != nil ?
          @project_file_path :
          Pathname.new(ProjectConfiguration.project_file_path)
              .join(@name)
    end

    def project_group_path
      return @project_group_path != nil ?
          @project_group_path :
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