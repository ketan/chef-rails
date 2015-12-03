# list of nodejs versions to install
default['nodejs-wrapper']['versions-to-install'] = ['4.0.0', '0.12.5']

# the default nodejs on path
default['nodejs-wrapper']['nvm']['default-version'] = '0.12.5'

# install these npm packages in every nodejs version that gets installed
default['nodejs-wrapper']['common-packages'] = %w(forever)

# install these packages with specific nodejs versions
default['nodejs-wrapper']['packages-to-install'] = {
  '0.12.5' => ['gulp', 'forever']
}
