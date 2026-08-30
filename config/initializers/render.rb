if Rails.env.production? && ENV["RENDER_EXTERNAL_URL"].present?
  uri = URI.parse(ENV["RENDER_EXTERNAL_URL"])

  Rails.application.routes.default_url_options[:host] = uri.host
  Rails.application.routes.default_url_options[:protocol] = uri.scheme

  Rails.application.config.action_mailer.default_url_options = {
    host: uri.host,
    protocol: uri.scheme
  }

  Rails.application.config.force_ssl = true
end
