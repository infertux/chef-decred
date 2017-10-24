name             'decred'
maintainer       'Cédric Félizard'
maintainer_email 'cedric@felizard.eu'
license          'MIT'
description      'Installs and configures Decred software'
source_url       'https://github.com/infertux/chef-decred'
issues_url       'https://github.com/infertux/chef-decred/issues'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'
chef_version     '>= 13.0'

supports 'debian'
supports 'ubuntu'

depends 'golang'
