require 'spec_helper_acceptance'

describe 'basic gerrit' do
  context 'default parameters' do
    xit 'should work with no errors' do
      Puppet.apply_catching_failures
      Puppet.apply_catching_changes
    end
  end
end
