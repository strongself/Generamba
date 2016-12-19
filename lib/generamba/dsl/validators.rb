module Generamba
  module DSL
    module Validators
      def validate(_validate_name, _options = {})
        result = Proc.new.call if block_given?
        # load plugin
        result = true unless block_given?

        raise Generamba::Error::Validator unless result
      end
    end
  end
end

extend Generamba::DSL::Validators
