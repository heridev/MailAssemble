require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AngularRailsAutoresponder
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.active_job.queue_adapter = :delayed_job

    config.autoload_paths << Rails.root.join('lib')

    config.middleware.insert_before 0, "Rack::Cors", debug: true, logger: (-> { Rails.logger }) do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          methods: [:post],
          max_age: 0
      end
    end
  end
end
