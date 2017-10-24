# DigitalOcean apt caches are out-of-date # TODO: remove
apt_update 'update' do
  action :update
end

ohai 'reload_passwd' do
  action :nothing
  plugin 'etc'
end

group node['decred']['group']

user node['decred']['user'] do
  manage_home true
  group node['decred']['group']
  home node['decred']['home']
  shell '/bin/bash'
  notifies :reload, 'ohai[reload_passwd]', :immediately
end

directory "#{node['decred']['home']}/.ssh" do
  owner node['decred']['user']
  group node['decred']['group']
  mode '0700'
end

file "#{node['decred']['home']}/.ssh/authorized_keys" do
  owner node['decred']['user']
  group node['decred']['group']
  mode '0400'
  content node['decred']['ssh_authorized_keys']
end

file '/etc/logrotate.d/decred' do
  owner 'root'
  group 'root'
  mode '0444'
  content <<-CONF.gsub(/^\s+/, '')
    #{node['decred']['home']}/.*/logs/*/*.log {
      weekly
      rotate 52
      compress
      delaycompress
    }
  CONF
end
