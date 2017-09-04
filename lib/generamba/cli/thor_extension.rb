require 'thor'

module Generamba::CLI
  class ::Thor
    no_commands do
      def ask_index(message, array)
        value_index = ask_with_validation(message,->(value){ (value.to_i >= 0 and value.to_i < array.count) },"Invalid selection. Please enter number from 0 to #{array.count-1}")
        return array[value_index.to_i]
      end

      def ask_non_empty_string(message, description = 'Value should be nonempty string')
        return ask_with_validation(message,->(value){value.length > 0 },description)
      end

      def ask_loop(message)
        array = Array.new
        loop do
          value = ask(message)
          break if value.empty?
          array.push(value)
        end
        return array
      end

      def ask_with_validation(message, is_valid_value, description = 'Invalid value')
        loop do
          value = ask(message)
          return value if is_valid_value.call(value)
          puts(description.red)
        end
      end

      def ask_file_with_path(pattern, message_file_name)
        project_files = Dir[pattern]
        count = project_files.count
        default_message = "The path to a #{message_file_name}:"
        if count == 1
          is_right_path = yes?"The path to a #{message_file_name} is '#{project_files[0]}'. Do you want to use it? (yes/no)"
          xcode_path = is_right_path ? project_files[0] : ask(default_message)
        else
          xcode_path = ask(default_message)
        end
        return xcode_path
      end
    end
  end
end