#!/bin/bash -eux

bundle update
bundle exec berks install
bundle exec berks update
bundle exec kitchen converge
bundle exec kitchen verify
# bundle exec kitchen destroy
