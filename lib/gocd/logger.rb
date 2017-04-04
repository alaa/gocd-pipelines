require 'logger'

module GOCD
  def logger
    STDOUT.sync = true
    @logger ||= Logger.new(STDOUT)
  end
  module_function :logger
end
