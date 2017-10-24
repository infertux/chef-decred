Decred Cookbook
===============
[![Cookbook](https://img.shields.io/cookbook/v/decred.svg)](https://supermarket.getchef.com/cookbooks/decred)
[![Build Status](https://travis-ci.org/infertux/chef-decred.svg?branch=master)](https://travis-ci.org/infertux/chef-decred)

This cookbook installs and configures various Decred software.

Requirements
------------

### network
In order to actively contribute to the Decred network, you will need to open your TCP port 9108.
This cookbook does *not* make sure your port 9108 is open since this is very much dependant on your networking setup.

Usage
-----

### `decred::dcrd` recipe

Install and configure the [Decred daemon](https://github.com/decred/dcrd).

### `decred::dcrwallet` recipe

Install and configure the [Decred CLI wallet](https://github.com/decred/dcrwallet).

License
-------
MIT
