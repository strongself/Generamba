require_relative 'spec_helper'

describe 'XcodeprojHelper' do
    describe 'method add_file_to_target?' do
      it 'should return true for Swift file' do
        filename = 'Test.swift'
        result = Generamba::XcodeprojHelper::is_compile_source?(filename)
        expect(result).to eq(true)
      end

      it 'should return true for Obj-C file' do
        filename = 'Test.m'
        result = Generamba::XcodeprojHelper::is_compile_source?(filename)
        expect(result).to eq(true)
      end

      it 'should return true for C++ file' do
        filename = 'Test.mm'
        result = Generamba::XcodeprojHelper::is_compile_source?(filename)
        expect(result).to eq(true)
      end
    end

    describe 'method add_file_to_bundle_resources?' do
      it 'should return true for Xib file' do
        resource_name = 'Test.xib'
        result = Generamba::XcodeprojHelper::is_bundle_resource?(resource_name)
        expect(result).to eq(true)
      end

      it 'should return true for Storyboard file' do
        resource_name = 'Test.storyboard'
        result = Generamba::XcodeprojHelper::is_bundle_resource?(resource_name)
        expect(result).to eq(true)
      end
    end
end
