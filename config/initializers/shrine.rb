require "shrine"
require "shrine/storage/file_system"
# require "shrine/storage/s3"

s3_options = { 
  bucket:            ENV['bucket'], 
  region:            ENV['region'],
  access_key_id:     ENV['access_key_id'],
  secret_access_key: ENV['secret_access_key'],
}

storage_options = if Rails.env.production?
  { 
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary 
    store: Shrine::Storage::S3.new(**s3_options),                  # permanent 
  }
else
  {
    cache: Shrine::Storage::FileSystem.new("/tmp", prefix: "uploads/cache"), # temporary
    store: Shrine::Storage::FileSystem.new("/tmp", prefix: "uploads"),       # permanent
  }
end

Shrine.storages = storage_options
Shrine.plugin :mongoid                # loads Mongoid integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
