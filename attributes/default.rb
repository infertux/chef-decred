default['decred']['user'] = 'decred'
default['decred']['group'] = 'decred'
default['decred']['ssh_authorized_keys'] = ''
default['decred']['home'] = "/home/#{default['decred']['user']}"
default['decred']['gopath'] = "#{default['decred']['home']}/go"
default['decred']['debuglevel'] = 'info'
default['decred']['testnet'] = '0'
default['decred']['network'] = 'mainnet' # e.g. testnet2

default['decred']['dcrinstall']['version'] = '1.1.0'
default['decred']['dcrinstall']['checksum'] = '35a35a7726a984c11c42d34fe3474852e60679bc0adc2bc416cc468b027c9d7f'

default['decred']['dcrd']['username'] = 'root'
default['decred']['dcrd']['password'] = 'changeme' # TODO

default['decred']['dcrwallet']['passphrase'] = '' # TODO
default['decred']['dcrwallet']['dummywallet'] = false
