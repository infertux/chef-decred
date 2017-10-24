include_recipe 'decred::_common'
include_recipe 'decred::dcrinstall'

template "#{node['decred']['home']}/.dcrd/dcrd.conf" do
  owner node['decred']['user']
  group node['decred']['group']
  mode '0400'
  notifies :restart, 'systemd_unit[dcrd.service]'
end

systemd_unit 'dcrd.service' do
  content <<-SYSTEMD.gsub(/^\s+/, '')
    [Unit]
    Description=Decred dcrd

    [Service]
    Type=simple
    User=#{node['decred']['user']}
    Group=#{node['decred']['group']}
    WorkingDirectory=#{node['decred']['home']}
    ExecStart=#{node['decred']['home']}/decred/dcrd
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
  SYSTEMD

  action %i[create enable start]
end
