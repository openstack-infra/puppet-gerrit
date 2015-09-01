require 'spec_helper_acceptance'

describe 'basic gerrit' do
  context 'module is working' do
    def pp_path
      base_path = File.dirname(__FILE__)
      File.join(base_path, 'fixtures')
    end

    def preconditions_puppet_module
      module_path = File.join(pp_path, 'preconditions.pp')
      File.read(module_path)
    end

    def default_puppet_module
      module_path = File.join(pp_path, 'default.pp')
      File.read(module_path)
    end

    before(:all) do
      apply_manifest(preconditions_puppet_module, catch_failures: true)
    end

    it 'should work with no errors' do
      apply_manifest(default_puppet_module, catch_failures: true)
    end

    it 'should be idempotent' do
      pending("this module is not idempotent, yet.")
      apply_manifest(default_puppet_module, catch_failures: true)
      apply_manifest(default_puppet_module, catch_changes: true)
    end
  end
end
