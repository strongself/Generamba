module Generamba
  module Error
    class UndefinedTemplateName < StandardError
      def message
        'I don`t know this template. Try run `generamba template:install`'
      end
    end

    class UndefinedTemplateVersion < StandardError
      def message
        'I don`t find this version. Try run `generamba template:install`'
      end
    end

    class IncorrectRepository < StandardError
      def message
        'repository don`t contains `rambaspec` file'
      end
    end

    class Validator < StandardError
      def message
        'validator raise error'
      end
    end
  end
end
