schedule_file = "config/schedule.yml"

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://127.0.0.1:6379', size: 7, network_timeout: 10 }
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://127.0.0.1:6379', size: 7, network_timeout: 10 }
  config.error_handlers << proc do |excexption, ctx_hash|
    error_hash = ctx_hash.deep_dup
    error_hash[:exception] = {
      class: excexption.class,
      message: excexption.message
    } if excexption.present?
    # Rollbar.error(error_hash)
  end
end

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  # Protect against timing attacks:
  # - See https://codahale.com/a-lesson-in-timing-attacks/
  # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
  # - Use & (do not use &&) so that it doesn't short circuit.
  # - Use digests to stop length information leaking
  Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(user), ::Digest::SHA256.hexdigest('admin')) &
  Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest('admin'))
end
