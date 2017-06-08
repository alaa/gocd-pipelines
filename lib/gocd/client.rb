require 'rest-client'
require 'uri'

module GOCD
  class Client
    ALLOWED_METHODS = [:get, :post, :delete, :put, :patch, :options].freeze

    class << self
      def send(method:, endpoint:, payload:, headers:)
        fail NotAllowedMethod unless ALLOWED_METHODS.include?(method)
        begin
          if payload
            p RestClient.public_send(method, uri(endpoint), payload, headers)
          else
            p RestClient.public_send(method, uri(endpoint), headers)
          end
        rescue RestClient::ExceptionWithResponse => e
          p e
          return e.response
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
