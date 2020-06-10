#
# Cookbook:: buildkite_agent
# Recipe:: centos
#
# Copyright:: 2019, The Authors, All Rights Reserved.
yum_repository 'Buildkite Pty Ltd' do
  repositoryid 'buildkite-agent'
  priority '1'
  baseurl 'https://yum.buildkite.com/buildkite-agent/stable/x86_64'
  gpgcheck false
end

include_recipe '::_configure'
