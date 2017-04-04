require 'yaml'

module GOCD
  class Flow
    attr_accessor :flow, :pipelines

    def initialize(flow)
      #TODO: validate ymal schema.
      @flow = flow
      fail GroupNotFound unless @flow.include?('group')
      fail PipelineNotFound unless @flow.include?('pipelines')

      @pipelines = @flow['pipelines']
    end

    def bootstrap
      #TODO: Refactor.
      group = @flow['group']

      @pipelines.each do |pipeline|
        env    = pipeline['env']
        pipeline_name = sprintf("%s.%s", group, pipeline['name'])

        materials = pipeline['materials'].each_with_object([]) do |material, materials|
          case material['type']
          when 'git'
            materials << GOCD::Material.git(repo: material['repo'], branch: material['branch'])
          when 'dependency'
            materials << GOCD::Material.dependency(upstream_pipeline: material['upstream_pipeline'], upstream_stage: material['upstream_stage'])
          end
        end

        stages = pipeline['stages'].each_with_object([]) do |stage, stages|
          jobs = stage["jobs"].each_with_object([]) do |job, jobs|
            tasks = job['tasks'].each_with_object([]) do |task, tasks|
              case task['type']
              when 'exec'
                tasks << GOCD::Task.exec(bash_command: task['command'])
              when 'fetch_artifact'
                tasks << GOCD::Task.fetch_artifact(upstream_pipeline: task['upstream_pipeline'], upstream_stage: task['upstream_stage'], upstream_job: task['upstream_job'])
              end
            end
            jobs << GOCD::Job.create(name: job['name'], tasks: tasks)
          end
          stages << GOCD::Stage.create(name: stage['name'], manual: stage['manual'], jobs: jobs)
        end
        GOCD::Pipeline.create(group: group, name: pipeline_name, materials: materials, stages: stages)
        GOCD::Env.patch(environment: env, pipelines: { add: [pipeline_name] })
      end
    end

    class GroupNotFound    < Exception; end
    class MaterialNotFound < Exception; end
    class PipelineNotFound < Exception; end
    class JobNotFound      < Exception; end
    class TaskNotFound     < Exception; end
  end
end
