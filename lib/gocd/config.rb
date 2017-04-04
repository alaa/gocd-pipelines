module GOCD
  class Config
    class << self
      attr_accessor :host, :port

      def url
        @url ||= sprintf("http://%s:%s", @host, @port)
      end
    end
  end
end
