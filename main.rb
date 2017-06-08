require_relative './lib/gocd'

GOCD::Config.host = "gocd-server.prod01.internal.advancedtelematic.com"
GOCD::Config.port = 8153

%w(ci.env.yml).each do |x|
  data = YAML.load_file(x)
  flow = GOCD::Flow.new(data)
  flow.bootstrap_environments
end

%w(device-registry.yml sota3.yml).each do |x|
  data = YAML.load_file(x)
  flow = GOCD::Flow.new(data)
  flow.bootstrap
end
