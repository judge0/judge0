require 'aws-sdk-s3'

Aws.config.update(
  endpoint: ENV.fetch("AWS_ENDPOINT"),
  access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
  secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
  force_path_style: true,
  region: "us-east-1"
)