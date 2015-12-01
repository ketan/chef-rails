include_recipe 'nginx'
include_recipe 'rvm::system_install'

rvm_ruby node['nginx-wrapper']['ruby']['version']
rvm_default_ruby node['nginx-wrapper']['ruby']['version']

rvm_gemset "#{node['nginx-wrapper']['my-app']['ruby-version']}@#{node['nginx-wrapper']['my-app']['gemset-name']}"

nginx_site 'my-app' do
  template "my-app.conf.erb"
end
