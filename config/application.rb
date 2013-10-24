begin
  File.open(".env").each_line do |line|  
    tokens = line.split("=")
    if tokens.length > 0 && !tokens[1].nil? && !tokens[0].nil?
      ENV[tokens[0].strip] ||= tokens[1].strip.chomp
    end
  end
rescue
  puts "couldn't find a file .env to source variables from"
end

ENV['DATA_ENCRYPT_KEY'] ||= 'secret'

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RetentionfactoryEngine
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    
  config.assets.initialize_on_precompile = false
  config.assets.precompile += %w(  )
  #TODO
  #ENV['SSL_CERT_FILE'] = File.join(File.dirname(__FILE__),"curl_cacert.pem")
    
  config.autoload_paths  += %W(#{config.root}/lib)
  config.autoload_paths += Dir["#{config.root}/lib/**/"]    
    
  config.filter_parameters += [:password]


  end
end
