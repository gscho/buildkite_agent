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
  not_if "test -f #{node['buildkite-agent']['install_dir']}/.buildkite-agent/bin/buildkite-agent"
  live_stream true
end

bash 'start buildkite-agent' do
  code 'nohup ~/.buildkite-agent/bin/buildkite-agent start &'
  not_if 'pgrep buildkite-agent'
end

systemd_unit 'buildkite-agent.service' do
  content(Unit: {
            Description: 'Buildkite Agent',
            Documentation: 'https://buildkite.com/agent',
            After: %w(syslog.target network.target),
          },
          Service: {
            Type: 'simple',
            User: 'buildkite-agent',
            Environment: 'HOME=/var/lib/buildkite-agent',
            ExecStart: "#{node['buildkite-agent']['install_dir']}/.buildkite-agent/bin/buildkite-agent start",
            Restart: 'on-failure',
            RestartSec: '5',
            RestartForceExitStatus: 'SIGPIPE',
            TimeoutStartSec: '0',
            TimeoutStopSec: '0',
            KillMode: 'process',
          },
          Install: {
            WantedBy: 'multi-user.target',
          })
  verify false
  action [:create, :enable, :reload, :restart]
end
