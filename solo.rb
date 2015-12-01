chef_root = File.absolute_path(File.dirname(__FILE__))

cookbook_path    [File.join(chef_root, "cookbooks"), File.join(chef_root, "site-cookbooks")]
node_path        File.join(chef_root, "nodes")
role_path        File.join(chef_root, "roles")
environment_path File.join(chef_root, "environments")
data_bag_path    File.join(chef_root, "data_bags")
#encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"
Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef
