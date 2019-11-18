#
# Cookbook:: buildkite_agent
# Recipe:: debian
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update

%w[apt-transport-https sudo dirmngr].each do |pkg|
  apt_package pkg
end

include_recipe '::ubuntu'

