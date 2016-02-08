require 'spec_helper'

describe 'GenCommandTableParametersFormatter' do

  describe 'method prepare_parameters_for_displaying' do
    it 'should convert array of hash to array of strings' do
      expected_string = 'name1, name2'

      parameters = {
          'templates' => [
              {'name' => 'name1', 'path' => 'path1'},
              {'name' => 'name2', 'path' => 'path2'}
          ]
      }

      params = Generamba::GenCommandTableParametersFormatter.prepare_parameters_for_displaying(parameters)

      expect(params['templates']).to eq(expected_string)
    end
  end

end
