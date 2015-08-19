require 'spec_helper_acceptance'

describe 'required files and directories' do
  before(:all) do
    Puppet.apply
  end

  describe file('/var/log/gerrit') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/review_site') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/review_site/plugins') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/.ssh') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/review_site/etc') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/review_site/bin') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/review_site/static') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/review_site/hooks') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/review_site/lib') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'gerrit2' }
  end

  describe file('/home/gerrit2/review_site/etc/gerrit.config') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'gerrit2' }
    it { should be_grouped_into 'gerrit2' }
    it { should be_mode 644 }
  end

  describe file('/home/gerrit2/review_site/etc/secure.config') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'gerrit2' }
    it { should be_grouped_into 'gerrit2' }
    it { should be_mode 600 }
  end

  describe file('/home/gerrit2/gerrit-wars') do
    it { should exist }
    it { should be_directory }
  end

  describe file('/etc/default/gerritcodereview') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 444 }
  end

  describe file('/etc/rc0.d/K10gerrit') do
    it { should be_symlink }
  end

  describe file('/etc/rc1.d/K10gerrit') do
    it { should be_symlink }
  end

  describe file('/etc/rc2.d/S90gerrit') do
    it { should be_symlink }
  end

  describe file('/etc/rc3.d/S90gerrit') do
    it { should be_symlink }
  end

  describe file('/etc/rc4.d/S90gerrit') do
    it { should be_symlink }
  end

  describe file('/etc/rc5.d/S90gerrit') do
    it { should be_symlink }
  end

  describe file('/etc/rc6.d/K10gerrit') do
    it { should be_symlink }
  end

  describe file('/usr/local/gerrit') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end

  describe file('/usr/local/gerrit/scripts') do
    it { should_not exist }
  end

  describe file('/home/gerrit2/review_site/lib/mysql-connector-java.jar') do
    it { should exist }
    it { should be_file }
  end

  describe file('/etc/mysql/conf.d/client.conf') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
end

