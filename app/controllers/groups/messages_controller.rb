class Groups::MessagesController < ApplicationController
before_action :set_variables

def index
end

def create
  @message = current_user.messages.new(message_params)
  if @message.save
    redirect_to group_messages_path(@group.id)
  else
    flash.now[:alert] = 'メッセージの入力が必要です'
    render :show
  end

end

private
def message_params
  binding.pry
  params.require(:message).permit(:body).merge(group_id: params[:group_id])
end

def set_variables
  binding.pry
  @group = Group.find(params[:group_id])
  @groups = current_user.groups
  @message = Message.new
  @messages = @group.messages
end

end
