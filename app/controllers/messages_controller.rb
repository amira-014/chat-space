class MessagesController < ApplicationController
  def index
    @users = User.all
    @group = Group.find(params[:group_id])
    @groups = Group.all
    @message = Message.new
    @messages = Message.where(group_id: params[:group_id])
  end

  def create
    @message = Message.new(body: message_params[:body], group_id: message_params[:group_id], user_id: current_user.id)
    if @message.save
      redirect_to group_messages_path(message_params[:group_id])
    else
      redirect_to group_messages_path(message_params[:group_id]),alert: 'メッセージの入力が必要です'
    end
  end

private
  def message_params
    params.require(:message).permit(:body).merge(group_id: params[:group_id])
  end
end
