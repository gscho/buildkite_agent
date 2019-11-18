#
# Cookbook:: buildkite_agent
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
case node['platform']
when 'ubuntu'
  include_recipe '::ubuntu'
when 'debian'
  include_recipe '::debian'
when 'centos'
  include_recipe '::centos'
else
  include_recipe '::linux'
end
