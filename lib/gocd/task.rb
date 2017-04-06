module GOCD
  class Task
    class << self

      def fetch_artifact(group:, upstream_pipeline:, upstream_stage:, upstream_job:)
        {
          type: "fetch",
          attributes: {
            pipeline: render_group(group: group, upstream: upstream_pipeline),
            stage: upstream_stage,
            job: upstream_job,
            source: "artifact.txt",
            is_source_a_file: true,
            run_if: ["passed"]
          }
        }
      end

      def exec(bash_command:)
        {
          type: "exec",
          attributes: {
            run_if: [ "passed" ],
            command: "/bin/bash",
            arguments: [ "-c", bash_command ],
            working_directory: nil
          }
        }
      end

      private

      def render_group(group:, upstream:)
        upstream.gsub('$group', group)
      end
    end
  end
end
