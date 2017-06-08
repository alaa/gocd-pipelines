require 'json'
require 'digest'
require 'rest-client'

module GOCD
  class Env
    class << self

      # Create an environment
      def create(name:)
        GOCD.logger.info("creating new environment #{name}")
        endpoint = "/go/api/admin/environments"
        headers = {
          "Accept" => "application/vnd.go.cd.v2+json",
          "Content-Type" => "application/json"
        }
        payload = {
          "name" => name,
        }.to_json
        resp = Client.send(method: :post, endpoint: endpoint, payload: payload, headers: headers)
      end

      # Update gocd environment's environment_variables
      def update(name:, environment_variables:)
        GOCD.logger.info("updating environment #{name}")
        endpoint = sprintf("/go/api/admin/environments/%s", name)
        headers = {
          'Accept' => 'application/vnd.go.cd.v2+json',
          'Content-Type' => 'application/json',
          "If-Match" => etag(name)
        }
        payload = {
          "name" => name,
          "environment_variables" => environment_variables,
        }.to_json
        resp = Client.send(method: :put, endpoint: endpoint, payload: payload, headers: headers)
      end

      # Patch environment pipelines
      def patch(environment:, pipelines:)
        GOCD.logger.info("Patching environment #{environment} with pipelines: #{pipelines}")
        endpoint = sprintf("/go/api/admin/environments/%s", environment)
        headers = {
          "Accept" => "application/vnd.go.cd.v2+json",
          "Content-Type" => "application/json"
        }
        payload = {
          "pipelines" => pipelines
        }.to_json
        resp = Client.send(method: :patch, endpoint: endpoint, payload: payload, headers: headers)
      end

      private

      def uri(endpoint)
        URI::join(Config.url, endpoint).to_s
      end

      def etag(name)
        GOCD.logger.info("fetching Etag for environment: #{name}")
        endpoint = sprintf("/go/api/admin/environments/%s", name)
        headers = {
          'Accept' => 'application/vnd.go.cd.v2+json',
          'Content-Type' => 'application/json'
        }
        resp = Client.send(method: :get, endpoint: endpoint, payload: nil,headers: headers)
        resp.headers[:etag]
      end
    end
  end
end
