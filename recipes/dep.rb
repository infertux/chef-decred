include_recipe 'decred::_common'
include_recipe 'decred::golang'

bash 'install_dep' do
  flags '-l'
  user node['decred']['user']
  group node['decred']['group']
  environment('HOME' => node['decred']['home'])
  not_if { File.exist?("#{node['decred']['gopath']}/bin/dep") }
  code <<-BASH
    go get -u -v github.com/golang/dep/cmd/dep
  BASH
end
