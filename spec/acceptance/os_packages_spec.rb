require 'spec_helper_acceptance'

describe 'operating system packages', :if => ['debian', 'ubuntu'].include?(os[:family]) do
  shared_examples "a required package is installed" do |packages|
    packages.each do |package|
      describe package(package) do
        it { should be_installed }
      end
    end
  end

  @installed_packages = ['gitweb', 'unzip', 'openjdk-7-jre-headless',
                         'libmysql-java', 'mysql-client', 'mysql-server']
  @installed_packages << 'apache2' if ['ubuntu', 'debian'].include?(os[:family])
  @installed_packages << 'httpd' if ['centos', 'redhat'].include?(os[:family])

  it_behaves_like "a required package is installed", @installed_packages

  shared_examples "an unnecessary package is not installed" do |packages|
    packages.each do |package|
      describe package(package) do
        it { should_not be_installed }
      end
    end
  end

  @unnecessary_packages = ['openjdk-6-jre-headless']

  it_behaves_like "an unnecessary package is not installed", @unnecessary_packages
end
