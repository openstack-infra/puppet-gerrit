require 'spec_helper_acceptance'

describe 'required files and directories' do
  describe file('/home/gerrit2/review_site/etc/gerrit.config') do
    it { should be_file }
    it { should contain('javaHome = /usr/lib/jvm/java-7-openjdk-amd64/jre') }
  end

  describe file('/home/gerrit2/review_site/etc/secure.config') do
    it { should be_file }
    it { should contain('password = 12345') }
  end

  describe file('/etc/default/gerritcodereview') do
    it { should be_file }
    it { should contain('GERRIT_SITE=/home/gerrit2/review_site') }
  end

  describe file('/etc/mysql/conf.d/client.conf') do
    it { should be_file }
    it { should contain('port          = 3306') }
  end

  describe file('/home/gerrit2/review_site/etc/ssh_host_rsa_key') do
    it { should be_file }
    it { should contain('qCXOyTKVLyuVxWWhfsWeAukgCpUrYDl3UlC5MB9O6HVFE60Ku2eEacHAkfE1bH0m') }
  end

  describe file('/home/gerrit2/review_site/etc/ssh_host_rsa_key.pub') do
    it { should be_file }
    it { should contain('ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhOkwk7azt0w+V7W1Rxy/GzNCp') }
  end

  describe file('/home/gerrit2/review_site/etc/ssh_project_rsa_key') do
    it { should be_file }
    it { should contain('JtMzz+BMrEuXuI6kQi5SF+VXAPD/Yn3MCo73YQIDAQABAoIBACKImeo0zpVj8e8j') }
  end

  describe file('/home/gerrit2/review_site/etc/ssh_project_rsa_key.pub') do
    it { should be_file }
    it { should contain('ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7hivh2k2Njf7rhl2bFoCnN30o') }
  end

  describe file('/home/gerrit2/.ssh/id_rsa') do
    it { should be_file }
    it { should contain('nLbwEj4EdDAixIqwsBuNFEfPH9D1qQtfhuVeh2+diEEDxzFVh+yvNAMng8or8aKL') }
  end

  describe file('/home/gerrit2/id_rsa.pub') do
    it { should be_file }
    it { should contain('ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQif+1etHAjqxdk4z2Gi4Sc+PM') }
  end
end
