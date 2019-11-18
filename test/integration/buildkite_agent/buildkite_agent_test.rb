# InSpec test for recipe buildkite_agent::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe file('/usr/bin/buildkite-agent') do
  it { should exist }
end

describe file('/etc/buildkite-agent/buildkite-agent.cfg') do
  it { should exist }
  its('content') { should match /foobar/ }
end
