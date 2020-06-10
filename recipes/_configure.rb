#
# Cookbook:: buildkite_agent
# Recipe:: _configure
#
# Copyright:: 2019, The Authors, All Rights Reserved.
package 'buildkite-agent' do
  version node['buildkite_agent']['version'] unless node['buildkite_agent']['version'].nil?
end

agent_conf = '/etc/buildkite-agent/buildkite-agent.cfg'
ruby_block 'set agent token' do
  block do
    file_edit = Chef::Util::FileEdit.new(agent_conf)
    file_edit.search_file_replace_line(/token=\"xxx\"/, "token=\"#{node['buildkite_agent']['token']}\"")
    file_edit.write_file
  end
  only_if { ::File.exist?(agent_conf) }
  not_if { ::File.readlines(agent_conf).grep(/#{Regexp.quote(node['buildkite_agent']['token'])}/).any? }
end

service 'buildkite-agent' do
  action %i(enable start)
end
