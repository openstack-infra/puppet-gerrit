require 'spec_helper_acceptance'

describe 'user', :if => ['debian', 'ubuntu'].include?(os[:family]) do
  describe user('gerrit2') do
    it { should exist }
    it { should belong_to_group 'gerrit2' }
    it { should have_home_directory '/home/gerrit2' }
    it { should have_login_shell '/bin/bash' }
  end
end
