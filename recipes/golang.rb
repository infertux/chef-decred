include_recipe 'golang::default'
include_recipe 'decred::_common'

%w[/ /bin /src].each do |suffix|
  directory "#{node['decred']['gopath']}#{suffix}" do
    owner node['decred']['user']
    group node['decred']['group']
  end
end

file "#{node['decred']['home']}/.profile" do
  owner node['decred']['user']
  group node['decred']['group']
  mode '0644'
end

ruby_block 'export GOPATH and GOBIN' do
  block do
    file = Chef::Util::FileEdit.new("#{node['decred']['home']}/.profile")

    [
      'export GOPATH=~/go',
      'export GOBIN=~/go/bin',
      'export PATH=$PATH:~/go/bin'
    ].each do |line|
      file.insert_line_if_no_match(Regexp.escape(line), line)
    end

    file.write_file
  end
end

bash 'check Go version' do
  flags '-l'
  user node['decred']['user']
  group node['decred']['group']
  environment('HOME' => node['decred']['home'])
  code <<-BASH
    set -eux
    go version
    go version | grep -Eq '^go version go#{node['go']['version']}(\.[0-9])? '
  BASH
end
