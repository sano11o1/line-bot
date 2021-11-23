class LineWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_line_client
  before_action :validate_signature
  
  def create
    render status: 200, json: { status: 200, message: 'OK Ranch!'}
  end

  private

    def set_line_client
      @line_client = Line::Bot::Client.new { |config|
        config.channel_id = ENV["LINE_CHANNEL_ID"]
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
    end
    
    def validate_signature
      body = request.body.read
      signature = request.env['HTTP_X_LINE_SIGNATURE']
      return if @line_client.validate_signature(body, signature)
      render status: 422, json: { status: 422, message: 'unprocessable entity'}
    end
end