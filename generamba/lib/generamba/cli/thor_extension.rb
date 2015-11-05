require 'thor'

module Generamba::CLI
  class ::Thor
    no_commands do
      def askIndex(message,array)
        valueIndex = askWithValidation(message,->(value){ (value.to_i >= 0 and value.to_i < array.count) },"Invalid selection. Please enter number from 0 to #{array.count-1}")
        return array[valueIndex.to_i]
      end

      def askNonEmptyString(message,description='Value should be nonempty string')
        return askWithValidation(message,->(value){value.length > 0 },description)
      end

      def askWithValidation(message,isValidValue,description='Invalid value')
        loop do
          value = ask(message)
          puts("value from input #{value}")
          break if isValidValue.call(value)
          puts(description)
        end
      end
    end
  end
end