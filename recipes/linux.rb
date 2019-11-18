#
# Cookbook:: buildkite_agent
# Recipe:: linux
#
# Copyright:: 2019, The Authors, All Rights Reserved.
remote_file '/tmp/install.sh' do
  mode '0755'
  source 'https://raw.githubusercontent.com/buildkite/agent/master/install.sh'
end

execute 'install buildkite-agent' do
  command 'bash /tmp/install.sh'
  environment 'TOKEN' => node['buildkite_agent']['token']
  not_if 'test -f ~/.buildkite-agent/bin/buildkite-agent'
  live_stream true
end

bash 'start buildkite-agent' do
  code 'nohup ~/.buildkite-agent/bin/buildkite-agent start &'
  not_if 'pgrep buildkite-agent'
end
