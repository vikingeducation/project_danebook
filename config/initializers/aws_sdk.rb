unless Rails.env.test?
  if Rails.env.development?
    AWS_Config = YAML.load_file("config/aws.yml")[Rails.env]
    ENV['AWS_BUCKET_NAME']       = AWS_Config['bucket']
    ENV['AWS_REGION']            = AWS_Config['region']
    ENV['AWS_ACCESS_KEY_ID']     = AWS_Config['access_key_id']
    ENV['AWS_SECRET_ACCESS_KEY'] = AWS_Config['secret_access_key']

  end

  Aws.config.update({
    region: ENV['AWS_REGION'],
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    })

  S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_BUCKET_NAME'])
end
