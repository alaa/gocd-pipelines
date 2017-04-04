require 'json'

module GOCD
  class Env
    class << self
      def create(name:)
        GOCD.logger.info("creating new environment #{name}")
        endpoint = "/go/api/admin/environments"
        headers = {
          "Accept" => "application/vnd.go.cd.v1+json",
          "Content-Type" => "application/json"
        }
        payload = { "name" => name }.to_json
        Client.send(method: :post, endpoint: endpoint, payload: payload, headers: headers)
      end

      def patch(environment:, pipelines: {add: []})
        GOCD.logger.info("Patching environment #{environment}")
        endpoint = sprintf("/go/api/admin/environments/%s", environment)
        headers = {
          "Accept" => "application/vnd.go.cd.v1+json",
          "Content-Type" => "application/json"
        }
        payload = {
          "pipelines" => {
            "add" => [
              pipelines[:add].join(",")
            ]
          }
        }.to_json
        Client.send(method: :patch, endpoint: endpoint, payload: payload, headers: headers)
      end
    end
  end
end
