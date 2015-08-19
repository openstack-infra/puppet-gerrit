require 'beaker-rspec'

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  mod_name = JSON.parse(open('metadata.json').read)['name'].split('-')[1]
  # Default puppet module
  puppet_module_path = File.join(proj_root, 'spec', 'acceptance', 'fixtures', 'default.pp')
  default_puppet_module = File.read(puppet_module_path)

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    hosts.each do |host|
      # Install puppet
      install_puppet_on(host)

      # Clean out any module cruft
      on host, "rm -fr #{host['distmoduledir']}/*"

      # Install git
      install_package host, 'git'

      zuul_ref = ENV['ZUUL_REF']
      zuul_branch = ENV['ZUUL_BRANCH']
      zuul_url = ENV['ZUUL_URL']

      # Install dependent modules via git or zuul
      r = on host, "test -e /usr/zuul-env/bin/zuul-cloner", { :acceptable_exit_codes => [0,1] }
      repo = 'openstack-infra/system-config'
      if r.exit_code == 0
        zuul_clone_cmd = '/usr/zuul-env/bin/zuul-cloner '
        zuul_clone_cmd += '--cache-dir /opt/git '
        zuul_clone_cmd += "--zuul-ref #{zuul_ref} "
        zuul_clone_cmd += "--zuul-branch #{zuul_branch} "
        zuul_clone_cmd += "--zuul-url #{zuul_url} "
        zuul_clone_cmd += "git://git.openstack.org #{repo}"
        on host, zuul_clone_cmd
      else
        on host, "git clone https://git.openstack.org/#{repo} #{repo}"
      end

      on host, "ZUUL_REF=#{zuul_ref} ZUUL_BRANCH=#{zuul_branch} ZUUL_URL=#{zuul_url} bash #{repo}/tools/install_modules_acceptance.sh"
      on host, "rm -fr #{host['distmoduledir']}/#{mod_name}"

      # Install the module being tested
      puppet_module_install(:source => proj_root, :module_name => mod_name)
      on host, "rm -fr #{repo}"

      # List modules installed to help with debugging
      on host, puppet('module','list'), { :acceptable_exit_codes => 0 }
      apply_manifest_on host, default_puppet_module
    end
  end
end
