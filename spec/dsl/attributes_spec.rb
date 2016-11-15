describe Generamba::DSL::Attributes do
  describe '#get' do
    it 'should put value into ramba_options' do
      set :variable, 'some value'
      expect(ramba_options).not_to be_empty
    end

    it 'should wrap global variables in global key' do
      set :global_variable, 'some value'
      expect(ramba_options).to eq({ global: { global_variable: 'some value' } })
    end

    it 'should wrap variables in ramba name key' do
      ramba :ramba_name do
        set :variable, 'some value'
      end
      Rake::Task[:ramba_name].invoke

      expect(ramba_options).to eq({ ramba_name: { variable: 'some value' } })
    end
  end

  describe '#set' do
    it 'should return value from ramba_options' do
      set :variable, 'some value'
      expect(get(:variable)).to eq('some value')
    end

    it 'should return value if ramba_options inluded lambda' do
      set :variable, -> { 1 + 1 }
      expect(get(:variable)).to eq(2)
    end

    it 'should return personal value for ramba' do
      set :variable, 'some value'

      ramba :ramba_name do
        set :variable, 'personal value'
        expect(get(:variable)).to eq('personal value')
      end
      Rake::Task[:ramba_name].invoke

      expect(get(:variable)).to eq('some value')
    end
  end
end
