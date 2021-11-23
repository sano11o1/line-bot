class LineWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_line_client
  before_action :validate_signature
  
  def create
    events = params['events']
    if !events.empty?
      user_id = params['events'][0]['source']['userId']
      if events[0]['message']['text'] == 'ユーザー登録'
        response = @line_client.get_profile(user_id)
        parsed_body= JSON.parse(response.body)
        if User.find_by(line_user_id: user_id)
          @line_client.reply_message(events[0]['replyToken'], {type: 'text', text: 'ユーザー登録済みです'})
        else
          User.create(name: parsed_body['displayName'], line_user_id: user_id)
          @line_client.reply_message(events[0]['replyToken'], {type: 'text', text: 'ユーザーを作成しました！'})
        end
      else
        @line_client.reply_message(events[0]['replyToken'], {type: 'text', text: 'そのメッセージには応答できません'})
      end
    end
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

    def get_profile(user_id)
      @line_client.get_profile(user_id)
    end
    
    def validate_signature
      body = request.body.read
      signature = request.env['HTTP_X_LINE_SIGNATURE']
      return if @line_client.validate_signature(body, signature)
      render status: 422, json: { status: 422, message: 'unprocessable entity'}
    end
end