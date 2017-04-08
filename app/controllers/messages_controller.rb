class MessagesController < ApplicationController
  def index
  end
  def create
    message = message_params[:message]
  end

private
  def message_params
    params.permit(:message)
  end
end
