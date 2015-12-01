# -*- mode: ruby -*-
# vi: set ft=ruby :


module ProvisionHelper
  def provision(provider, override, synced_folder_type=:virtualbox)
    override.vm.provision 'shell', path: 'initialize.sh'
    override.vm.provision 'chef_solo' do |chef|
      chef.synced_folder_type = synced_folder_type

      chef.cookbooks_path    = ["cookbooks", "site-cookbooks"]
      chef.roles_path        = "roles"
      chef.environments_path = "environments"
      chef.data_bags_path    = "data_bags"
      chef.json              = JSON.parse(File.read('nodes/node.json'))
    end
  end

  module_function :provision
end

Vagrant.configure(2) do |config|

  # disable default synced, override as necessary in each provider
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :virtualbox do |vb, override|
    override.vm.box = "ubuntu/trusty64"
    config.vm.synced_folder ".", "/vagrant"

    vb.gui    = false
    vb.cpus   = 4
    vb.memory = 1024 * 2

    ProvisionHelper.provision(vb, override)
  end

  config.vm.provider :aws do |aws, override|
    override.nfs.functional = false
    override.vm.synced_folder ".", "/vagrant", disabled: true

    override.vm.box               = 'dummy'
    aws.access_key_id             = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key         = ENV['AWS_SECRET_ACCESS_KEY']

    aws.instance_type             = 'm3.medium'
    aws.ami                       = 'ami-47a23a30'
    aws.keypair_name              = ENV['AWS_KEYPAIR_NAME']
    aws.region                    = 'eu-west-1'

    override.ssh.username         = "ubuntu"
    override.ssh.private_key_path = '~/.ssh/id_rsa'

    ProvisionHelper.provision(aws, override, :rsync)
  end

  # if you have these plugins things may go faster
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
    config.cache.enable :apt
    config.cache.enable :apt_lists
    config.cache.enable :yum
  end

  # make sure you have a proxy server running
  if Vagrant.has_plugin?('vagrant-proxyconf')
    config.proxy.enabled  = false
    config.proxy.http     = 'http://10.0.2.2:3128/'
    config.proxy.https    = 'http://10.0.2.2:3128/'
    config.proxy.no_proxy = 'localhost,127.0.0.1,10.0.2.2,172.16.18.1,172.16.38.21'
  end

  if Vagrant.has_plugin?('vagrant-ohai')
    config.ohai.primary_nic = "eth1"
  end

end
