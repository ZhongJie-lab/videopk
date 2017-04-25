CarrierWave.configure do |config|
  if Rails.env.production?
    # config.fog_credentials = {
    #   provider:               'AWS',
    #   aws_access_key_id:      ENV["AWS_ACCESS_KEY_ID"],
    #   aws_secret_access_key:  ENV["AWS_SECRET_ACCESS_KEY"],
    #   region:                 ENV["AWS_REGION"]
    # }
    # config.storage :fog
    # config.fog_directory = ENV["AWS_BUCKET_NAME"]
    config.storage = :upyun
    config.upyun_username = ENV["UPYUN_OPERATOR_ID"]
    config.upyun_password = ENV["UPYUN_OPERATOR_PASSWORD"]
    config.upyun_bucket = ENV["UPYUN_BUCKET"]
    config.upyun_bucket_host = ENV["UPYUN_HOST"]
  else
    config.storage :file
  end
end
