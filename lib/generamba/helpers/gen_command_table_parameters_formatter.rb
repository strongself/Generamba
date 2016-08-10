module Generamba
  # Provides methods for prepare parameters for displaying in table.
  class GenCommandTableParametersFormatter
    # This method prepared parameter for displaying
    def self.prepare_parameters_for_displaying(parameters)
      params = parameters.clone

      templates = []

      params['templates'].each do |param|
        templates.push(param['name'])
      end

      params['templates'] = templates.join("\n")

      params
    end
  end
end
