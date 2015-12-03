action :install do
  package_name = new_resource.name
  package_version = new_resource.version
  node_version = new_resource.node_version

  resource_msg = if package_version.nil?
    "install #{package_name} for nodejs-#{node_version}"
  else
    "install #{package_name} v#{package_version} for nodejs-#{node_version}"
  end

  bash resource_msg do
    code <<-BASH
      source $NVM_DIR/nvm.sh
      nvm exec #{node_version} npm install #{package_name}#{package_version ? "@#{package_version}" : ''}  -g
    BASH

    creates "#{node['nvm']['directory']}/v#{node_version}/lib/node_modules/#{package_name}"
    env     'NVM_DIR' => node['nvm']['directory']
  end
end
