describe Generamba::DSL::Validators do
  describe '#validate' do
    context 'when has block' do
      it 'should raise error if it return false' do
        expect {
          validate :test_validator do
            false
          end
        }.to raise_error(Generamba::Error::Validator)
      end

      it 'should remain silent if it return true' do
        expect {
          validate :test_validator do
            true
          end
        }.not_to raise_error
      end
    end

    context 'when has no block' do
      pending 'should run plugin'
    end
  end
end
