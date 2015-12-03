include_recipe 'nvm'

node['nodejs-wrapper']['versions-to-install'].each do |node_version|

  # install all node version
  nvm_install node_version  do
  	from_source      false
  	alias_as_default false
  	action           :create
  end

  # install all common packages in each node
  node['nodejs-wrapper']['common-packages'].each do |package|
    nodejs_wrapper_npm package do
      node_version node_version
      action :install
    end
  end
end

node['nodejs-wrapper']['packages-to-install'].each do |node_version, packages|
  packages.each do |package|
    nodejs_wrapper_npm package do
      node_version node_version
      action :install
    end
  end
end

nvm_alias_default node['nodejs-wrapper']['nvm']['default-version'] do
  action :create
end
