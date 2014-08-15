AssetSync.configure do |config|
  config.fog_provider = ENV['FOG_PROVIDER']
  config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
  config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  # To use AWS reduced redundancy storage.
  # config.aws_reduced_redundancy = true

  # config.rackspace_username
  # config.rackspace_api_key

  # config.google_storage_access_key_id
  # config.google_storage_secret_access_key

  config.fog_directory = ENV['FOG_DIRECTORY']

  # Invalidate a file on a cdn after uploading files
  # config.cdn_distribution_id = "12345"
  # config.invalidate = ['file1.js']

  # Increase upload performance by configuring your region
  config.fog_region = ENV['FOG_REGION']
  #
  # Don't delete files from the store
  config.existing_remote_files = ENV['ASSET_SYNC_EXISTING_REMOTE_FILES']
  #
  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = ENV['ASSET_SYNC_GZIP_COMPRESSION']
  #
  # Use the Rails generated 'manifest.yml' file to produce the list of files to
  # upload instead of searching the assets directory.
  config.manifest = ENV['ASSET_SYNC_MANIFEST']
  #
  # Fail silently.  Useful for environments such as Heroku
  # config.fail_silently = true
end
