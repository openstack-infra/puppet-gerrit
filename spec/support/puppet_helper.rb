module Puppet
  PUPPET_MODULE_PATH = '/etc/puppet/modules'

  def self.apply
    pp = self.read_puppet_module
    apply_manifest(pp, module_path: PUPPET_MODULE_PATH)
  end

  def self.apply_catching_changes
    pp = self.read_puppet_module
    apply_manifest(pp, catch_changes: true, module_path: PUPPET_MODULE_PATH)
  end

  def self.apply_catching_failures
    pp = self.read_puppet_module
    apply_manifest(pp, catch_failures: true, module_path: PUPPET_MODULE_PATH)
  end

  private

  def self.read_puppet_module
    base_path = File.dirname(__FILE__)
    pp_path = File.join(base_path, '..', 'acceptance', 'fixtures', 'default.pp')
    File.read(pp_path)
  end
end
