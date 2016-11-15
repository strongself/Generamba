describe Generamba::DSL::Methods do
  describe '#invoke' do
    it 'should run another ramba' do
      ramba :invoked_ramba do
        set :invoked_ramba_option, 1
      end

      invoke :invoked_ramba

      expect(ramba_options).to eq({ invoked_ramba: { invoked_ramba_option: 1 } })
    end
  end

  describe '#sh' do
    it 'should run shell command' do
      command_out = sh('echo hello')
      expect(command_out).to match_array(['hello'])
    end
  end
end
