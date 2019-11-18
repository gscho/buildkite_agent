#
# Cookbook:: buildkite_agent
# Recipe:: darwin
#
# Copyright:: 2019, The Authors, All Rights Reserved.
homebrew_tap 'buildkite/buildkite'

homebrew_package 'buildkite-agent' do
  options "--token='#{node['buildkite_agent']['token']}'"
end
