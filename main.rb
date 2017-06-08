require_relative './lib/gocd'

GOCD::Config.host = "gocd-server.prod01.internal.advancedtelematic.com"
GOCD::Config.port = 8153

environments_dir = 'conf/environments/'
pipelines_dir    = 'conf/pipelines/'

Dir["#{environments_dir}*.yml"].each do |f|
  data = YAML.load_file(f)
  flow = GOCD::Flow.new(data)
  flow.bootstrap_environments
end

Dir["#{pipelines_dir}*.yml"].each do |f|
  data = YAML.load_file(f)
  flow = GOCD::Flow.new(data)
  flow.bootstrap_pipelines
end
