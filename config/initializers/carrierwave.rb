# check that aws.yml exists
if File.exists? Rails.root.join('config', 's3.yml')

  data = YAML::load_file(File.open(Rails.root.join('config', 's3.yml')))[Rails.env.to_s]

  ENV["AWS_ACCESS_KEY_ID"] ||= data["AWS_ACCESS_KEY_ID"]
  ENV["AWS_SECRET_ACCESS_KEY"] ||= data["AWS_SECRET_ACCESS_KEY"]
  ENV["AWS_S3_BUCKET"] ||= data["AWS_S3_BUCKET"]
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => "AWS",
    :aws_access_key_id      =>  ENV["AWS_ACCESS_KEY_ID"],
    :aws_secret_access_key  =>  ENV["AWS_SECRET_ACCESS_KEY"]
  }
  config.fog_directory  = ENV["AWS_S3_BUCKET"]
end
