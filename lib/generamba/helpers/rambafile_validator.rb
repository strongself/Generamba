module Generamba
  # Provides methods for validating Rambafile contents
  class RambafileValidator
    # Method validates Rambafile contents
    # @param path [String] The path to a Rambafile
    #
    # @return [Void]
    def validate(path)
      file_contents = open(path).read
      preferences = file_contents.empty? ? {} : YAML.load(file_contents).to_hash

      unless preferences[TEMPLATES_KEY]
        puts "You can't run *generamba gen* without any templates installed. Add their declarations to a Rambafile and run *generamba template install*.".red
        exit
      end
    end
  end
end
