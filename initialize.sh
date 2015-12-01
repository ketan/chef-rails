#!/bin/bash

# initialize a base ubuntu VM so it can be bootstrapped further using chef

if [ -f /usr/bin/chef-solo ] && [ ! -f /opt/chef/bin/chef-solo ]; then
  echo "Purging chef that appears to have been provided by ubuntu"
  apt-get purge chef -y
fi

if ! [ -x /opt/chef/bin/chef-solo ]; then
  echo "installing omnibus chef"
  curl --silent --fail --location https://www.opscode.com/chef/install.sh | bash -s -- -v 12
fi

apt-get -y autoremove
apt-get update
