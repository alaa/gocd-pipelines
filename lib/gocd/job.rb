module GOCD
  class Job
    class << self
      def create(name:, tasks:)
        {
          name: name,
          run_instance_count: nil,
          timeout: 0,
          environment_variables: [],
          resources: [],
          artifacts: [
            source: "artifact.txt",
            type: "build"
          ],
          tasks: tasks
        }
      end
    end
  end
end
