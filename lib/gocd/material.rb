module GOCD
  class Material
    class << self

      def dependency(upstream_pipeline:, upstream_stage:)
        {
          type: "dependency",
          attributes: {
            pipeline: upstream_pipeline,
            stage: upstream_stage,
            auto_update: true
          }
        }
      end

      def git(repo:, branch:)
        {
          type: "git",
          attributes: {
            url: repo,
            filter: nil,
            invert_filter: false,
            name: nil,
            auto_update: true,
            branch: branch,
            submodule_folder: nil,
            shallow_clone: true
          }
        }
      end
    end
  end
end
