include_recipe 'decred::_common'
include_recipe 'decred::dcrinstall'
include_recipe 'decred::dcrd'

template "#{node['decred']['home']}/.dcrwallet/dcrwallet.conf" do
  owner node['decred']['user']
  group node['decred']['group']
  mode '0400'
  notifies :restart, 'systemd_unit[dcrwallet.service]'
end

template "#{node['decred']['home']}/.dcrctl/dcrctl.conf" do
  owner node['decred']['user']
  group node['decred']['group']
  mode '0400'
end

directory "#{node['decred']['home']}/.dcrwallet/#{node['decred']['network']}" do
  owner node['decred']['user']
  group node['decred']['group']
  mode '0700'
end

file "#{node['decred']['home']}/.dcrwallet/passphrase" do
  owner node['decred']['user']
  group node['decred']['group']
  mode '0400'
  content node['decred']['dcrwallet']['passphrase']
  sensitive true
end

cookbook_file "#{node['decred']['home']}/.dcrwallet/#{node['decred']['network']}/wallet.db" do
  source 'dummywallet.db'
  owner node['decred']['user']
  group node['decred']['group']
  mode '0600'
  only_if { node['decred']['dcrwallet']['dummywallet'] }
end

systemd_unit 'dcrwallet.service' do
  content <<-SYSTEMD.gsub(/^\s+/, '')
    [Unit]
    Description=Decred dcrwallet
    ConditionPathExists=#{node['decred']['home']}/.dcrwallet/#{node['decred']['network']}/wallet.db

    [Service]
    Type=simple
    User=#{node['decred']['user']}
    Group=#{node['decred']['group']}
    WorkingDirectory=#{node['decred']['home']}
    ExecStart=/bin/bash -c 'exec #{node['decred']['home']}/decred/dcrwallet < #{node['decred']['home']}/.dcrwallet/passphrase'
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
  SYSTEMD

  action %i[create enable start]
end

log 'check for wallet.db' do
  level :warn
  message "No wallet.db found - log in via ssh then run `dcrwallet --create` as the #{node['decred']['user']} user."
  not_if { File.exist?("#{node['decred']['home']}/.dcrwallet/#{node['decred']['network']}/wallet.db") }
end
