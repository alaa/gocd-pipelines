{
  "name": "deploy-template",
  "materials": [
  {
    "type": "dependency",
    "attributes": {
      "pipeline": "#{PIPELINE}",
      "stage": "#{STAGE}",
      "auto_update": true
    }
  }
  ],
    "stages": [
    {
      "name": "deploy",
      "fetch_materials": true,
      "clean_working_directory": false,
      "never_cleanup_artifacts": true,
      "environment_variables": [],
      "jobs": [
      {
        "name": "deploy-to-marathon",
        "run_instance_count": null,
        "elastic_profile_id": null,
        "timeout": 0,
        "environment_variables": [],
        "resources": [],
        "tasks": [
        {
          "type": "fetch",
          "attributes": {
            "pipeline": "#{PIPELINE}",
            "stage": "#{STAGE}",
            "job": "#{JOB}",
            "source": "artifact.txt",
            "is_source_a_file": true,
            "run_if": ["passed"]
          }
        },
        {
          "type": "exec",
          "attributes": {
            "run_if": [
              "passed"
              ],
            "command": "/bin/bash",
            "arguments": [ "-c", "cat artifact.txt" ],
            "working_directory": null
          }
        }
        ]
      }
      ]
    }
  ]
}

