module GOCD
  class Material
    class << self

      def dependency(group:, upstream_pipeline:, upstream_stage:)
        {
          type: "dependency",
          attributes: {
            pipeline: render_group(group: group, upstream: upstream_pipeline),
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

      private

      def render_group(group:, upstream:)
        puts "============> GROUP IS: #{group}"
        upstream.gsub('$group', group)
      end
    end
  end
end
