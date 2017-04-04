require 'json'

module GOCD
  class Pipeline
    class << self
      def create(group:, name:, materials:, stages:)
        GOCD.logger.info("Creating Pipeline #{name}")
        endpoint = "/go/api/admin/pipelines"
        headers = {
          "Accept" => "application/vnd.go.cd.v3+json",
          "Content-Type" => "application/json"
        }
        payload = {
          group: group,
          pipeline: {
            enable_pipeline_locking: true,
            name: name,
            template: nil,
            materials: materials,
            stages: stages
          }
        }.to_json
        puts payload
        puts "\n\n\n"
        Client.send(method: :post, endpoint: endpoint, payload: payload, headers: headers)
      end

      def unpause(pipeline:)
        GOCD.logger.info("Unpausing Pipeline #{pipeline}")
        endpoint = sprintf("/go/api/pipelines/%s/unpause", pipeline)
        headers = {
          "Confirm" => true
        }
        payload = {}
        Client.send(method: :post, endpoint: endpoint, payload: payload, headers: headers)
      end
    end
  end
end
