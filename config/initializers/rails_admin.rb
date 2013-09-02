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
end
