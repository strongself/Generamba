describe Generamba::DSL::Hooks do
  describe '#error' do
    let(:error_hooks) { Rake.application.error_hooks }
    before { Rake.application.error_hooks = {}  }

    it 'should put proc into error_hooks' do
      error :test_error do end

      expect(error_hooks.keys).to match_array('test_error')
    end

    it 'should put proc into error_hooks with key - error_all if call error_each' do
      error_each {}

      expect(error_hooks.keys).to match_array('error_all')
    end
  end

  describe '#before' do
    let(:before_hooks) { Rake.application.before_hooks }
    before { Rake.application.before_hooks = {}  }

    it 'should put proc into before_hooks' do
      before :test_before do end

      expect(before_hooks.keys).to match_array('test_before')
    end

    it 'should put proc into before_hooks with key - before_all if call before_each' do
      before_each {}

      expect(before_hooks.keys).to match_array('before_all')
    end
  end

  describe '#after' do
    let(:after_hooks) { Rake.application.after_hooks }
    before { Rake.application.after_hooks = {}  }

    it 'should put proc into after_hooks' do
      after :test_after do end

      expect(after_hooks.keys).to match_array('test_after')
    end

    it 'should put proc into after_hooks with key - after_all if call after_each' do
      after_each {}

      expect(after_hooks.keys).to match_array('after_all')
    end
  end
end
