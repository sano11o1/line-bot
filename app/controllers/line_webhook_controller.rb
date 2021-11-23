class LineWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    p '-----------------------------------------------'
    p request
    p '-----------------------------------------------'
    render status: 200, json: { status: 200, message: 'OK Ranch!'}
  end
end