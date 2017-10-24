include_recipe 'decred::_common'
include_recipe 'decred::golang'

remote_file "#{node['decred']['home']}/dcrinstall" do
  owner node['decred']['user']
  group node['decred']['user']
  mode '0755'
  source "https://github.com/decred/decred-release/releases/download/v#{node['decred']['dcrinstall']['version']}/dcrinstall-linux-amd64-v#{node['decred']['dcrinstall']['version']}"
  checksum node['decred']['dcrinstall']['checksum']
  notifies :run, 'bash[dcrinstall]', :immediately
end

bash 'dcrinstall' do
  action :nothing
  user node['decred']['user']
  group node['decred']['user']
  environment('HOME' => node['decred']['home'])
  cwd node['decred']['home']
  code <<-BASH
    set -eux
    mkdir -p .dcrwallet/#{node['decred']['network']}
    touch .dcrwallet/#{node['decred']['network']}/wallet.db # workaround to skip wallet creation
    # XXX: https://github.com/decred/decred-release/blob/15d1f608e21aa1afbd05689a2454dbe49af294e8/cmd/dcrinstall/dcrinstall.go#L612
    ./dcrinstall
    grep decred .profile || echo 'export PATH=$PATH:~/decred' >> .profile
    test -s .dcrwallet/#{node['decred']['network']}/wallet.db || rm -rfv .dcrwallet/#{node['decred']['network']}
  BASH
end
