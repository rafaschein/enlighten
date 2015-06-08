# config/initializers/refile.rb
if ENV['ENL_AWS_ACCESS_KEY_ID'].present?
  require 'refile/s3'

  aws = {
    access_key_id: ENV['ENL_AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['ENL_AWS_ACCESS_KEY_SECRET'],
    region: ENV['ENL_AWS_ACCESS_KEY_REGION'],
    bucket: ENV['ENL_AWS_ACCESS_KEY_BUCKET'],
  }

  Refile.cache = Refile::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::S3.new(prefix: "store", **aws)
end
