require_relative './lib/gocd'

GOCD::Config.host = "gocd-server.prod01.internal.advancedtelematic.com"
GOCD::Config.port = 8153

data = YAML.load_file('device-registry.yml')
flow = GOCD::Flow.new(data)
flow.bootstrap
