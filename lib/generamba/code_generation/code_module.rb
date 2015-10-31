module Generamba

  # Represents currently generating code module
  class CodeModule
    attr_reader :name, :description, :author, :company, :year, :prefix, :project_name

    def initialize(name, description)
      @name = name
      @description = description
    end

    def author
      ProjectConfiguration.author
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
  end
end