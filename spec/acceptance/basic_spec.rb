require 'spec_helper_acceptance'

describe 'basic gerrit' do
  context 'module is working' do
    let(:default_puppet_module) do
      base_path = File.dirname(__FILE__)
      pp_path = File.join(base_path, 'fixtures', 'default.pp')
      File.read(pp_path)
    end

    it 'should work with no errors' do
      apply_manifest(default_puppet_module, catch_failures: true)
    end

    it 'should be idempotent' do
      pending("this module is not idempotent, yet.")
    end
  end
end
