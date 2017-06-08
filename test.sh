curl 'http://gocd-server.prod01.internal.advancedtelematic.com:8153/go/api/admin/environments/ci' \
      -H 'Accept: application/vnd.go.cd.v2+json' \
      -H 'Content-Type: application/json' \
      -X PATCH \
      -d '{
        "pipelines": {
          "add": ["sota3.ci.deploy", "sota3.ci.approve", "sota3.qa.deploy"]
        }
      }'
