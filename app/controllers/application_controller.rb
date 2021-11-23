class ApplicationController < ActionController::Base
  before_action :set_line_client

  private
    def set_line_client
      @line_client = Line::Bot::Client.new { |config|
        config.channel_id = ENV["LINE_CHANNEL_ID"]
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end
end
