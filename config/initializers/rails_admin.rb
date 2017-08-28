module RailsAdmin
  module Config
    module Actions
      # register custom action
      class UpdateMetadataFromVimeo < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
      end
    end
  end
end

RailsAdmin.config do |config|
  config.included_models = ["Station"]
  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      username == Rails.application.secrets.admin_username &&
      password == Rails.application.secrets.admin_password
    end
  end
end
