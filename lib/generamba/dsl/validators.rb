module Generamba
  module DSL
    module Validators
      def validate(validate_name, _ = {})
        result = Proc.new.call if block_given?
        # load plugin
        result = true unless block_given?

        raise "validator #{validate_name} raise error" unless result
      end
    end
  end
end

extend Generamba::DSL::Validators
