require 'rest-client'
require 'uri'

module GOCD
  class Client
    ALLOWED_METHODS = [:get, :post, :delete, :put, :patch, :options].freeze

    class << self
      def send(method:, endpoint:, payload:, headers:)
        fail NotAllowedMethod unless ALLOWED_METHODS.include?(method)
        begin
          RestClient.public_send(method, uri(endpoint), payload, headers)
        rescue RestClient::ExceptionWithResponse => err
          GOCD.logger.error(sprintf("Error %s. %s", name, err))
        end
      end

      private

      def uri(endpoint)
        URI::join(Config.url, endpoint).to_s
      end
    end

    class NotAllowedMethod < Exception; end
  end
end
