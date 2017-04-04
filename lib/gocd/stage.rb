module GOCD
  class Stage
    class << self
      def create(name:, manual:, jobs:)
        {
          name: name,
          fetch_materials: true,
          clean_working_directory: false,
          never_cleanup_artifacts: true,
          approval: {
            type: manual?(manual),
            authorization: {
              roles: [],
              users: []
            }
          },
          environment_variables: [],
          jobs: jobs
        }
      end

      private

      def manual?(manual)
        manual ? "manual" : "success"
      end
    end
  end
end
