require 'aws-sdk-s3'

Aws.config.update(
  access_key_id:     Rails.application.secrets.aws_access_key_id,
  secret_access_key: Rails.application.secrets.aws_secret_access_key,
  endpoint:          ENV.fetch("AWS_ENDPOINT"),
  force_path_style:  true,
  region:            "us-east-1"
)