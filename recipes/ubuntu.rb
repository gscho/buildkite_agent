#
# Cookbook:: buildkite_agent
# Recipe:: ubuntu
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_repository 'buildkite' do
  uri 'https://apt.buildkite.com/buildkite-agent'
  components %w(stable main)
  key '32A37959C2FA5C3C99EFBC32A79206696452D198'
  keyserver 'hkp://keyserver.ubuntu.com:80'
  distribution nil
end

apt_update

include_recipe '::_configure'

