require_relative 'spec_helper'

describe 'DependencyChecker' do
  before(:each) do
    @checker = Generamba::DependencyChecker
  end

  describe 'method check_all_required_dependencies_has_in_podfile' do
    it 'should do nothing' do
      dependencies = ['ViperMcFlurry']
      podfile_path = 'Podfile'

      expect(STDOUT).not_to receive(:puts).with("[Warning] Dependencies #{dependencies} missed in Podfile".yellow)

      @checker.check_all_required_dependencies_has_in_podfile(dependencies, nil)
      @checker.check_all_required_dependencies_has_in_podfile(nil, podfile_path)
    end

    it 'should show warning message' do
      dependencies = ['ViperMcFlurry']
      podfile_path = 'Podfile'

      allow(Pod::Podfile).to receive(:from_file).and_return(Pod::Podfile.new)
      expect(STDOUT).to receive(:puts).with("[Warning] Dependencies #{dependencies} missed in Podfile".yellow)

      @checker.check_all_required_dependencies_has_in_podfile(dependencies, podfile_path)
    end
  end

  describe 'method check_all_required_dependencies_has_in_cartfile' do
    it 'should do nothing' do
      dependencies = ['ViperMcFlurry']
      cartfile_path = 'Cartfile'

      expect(STDOUT).not_to receive(:puts).with("[Warning] Dependencies #{dependencies} missed in Cartfile".yellow)

      @checker.check_all_required_dependencies_has_in_cartfile(dependencies, nil)
      @checker.check_all_required_dependencies_has_in_cartfile(nil, cartfile_path)
    end

    it 'should show warning message if dependency missing' do
      dependencies = ['ViperMcFlurry']
      cartfile_path = 'Cartfile'

      allow(File).to receive(:read).and_return('Typhoon')
      expect(STDOUT).to receive(:puts).with("[Warning] Dependencies #{dependencies} missed in Cartfile".yellow)

      @checker.check_all_required_dependencies_has_in_cartfile(dependencies, cartfile_path)
    end

    it 'should not show warning message if dependency is in place' do
      dependencies = ['ViperMcFlurry']
      cartfile_path = 'Cartfile'

      allow(File).to receive(:read).and_return('github "Rambler-iOS/ViperMcFlurry"')
      expect(STDOUT).not_to receive(:puts).with("[Warning] Dependencies #{dependencies} missed in Cartfile".yellow)

      @checker.check_all_required_dependencies_has_in_cartfile(dependencies, cartfile_path)
    end
  end

end