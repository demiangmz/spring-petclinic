autoUpdate:
  enabled: false
  schedule: ""
terraform: true
cluster:
  clusterName: "${cluster_name}"
  environmentGitOwner: "${git_owner}"
  provider: eks
  region: "${region}"
gitops: true
environments:
  - key: dev
  - key: staging
  - key: production
ingress:
  domain: "${domain}"
  ignoreLoadBalancer: true
  externalDNS: ${enable_external_dns}
  namespaceSubDomain: -jx.
  tls:
    email: "${tls_email}"
    enabled: ${enable_tls}
    production: ${use_production_letsencrypt}
kaniko: true
secretStorage: vault
vault:
  aws:
    autoCreate: ${enable_autoCreate}
    iamUserName: "${vault_user}"
    dynamoDBTable: "${vault_dynamodb_table}"
    dynamoDBRegion: "${region}"
    kmsKeyId: "${vault_kms_key}"
    kmsRegion: "${region}"
    s3Bucket: "${vault_bucket}"
    s3Region: "${region}"
storage:
  logs:
    enabled: ${enable_logs_storage}
    url: s3://${logs_storage_bucket}
  reports:
    enabled: ${enable_reports_storage}
    url: s3://${reports_storage_bucket}
  repository:
    enabled: ${enable_repository_storage}
    url: s3://${repository_storage_bucket}
versionStream:
  ref: master
  url: https://github.com/jenkins-x/jenkins-x-versions.git
webhook: prow
