class GroupsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_group, only: [:edit, :update]

def index
  @groups = current_user.groups
end

def edit
end


def new
  @group = Group.new
end

def create
  @group = Group.new(group_params)
  if @group.save
    redirect_to group_messages_path(@group.id), notice: 'グループが作成されました'
  else
    flash.now[:alert] = 'グループの作成に失敗しました'
    render new_group_path
  end

end

def update
  if @group.update(group_params)
    redirect_to group_messages_path(@group.id), notice: 'グループが編集されました'
  else
    flash.now[:alert] = 'グループの編集に失敗しました'
    render :edit
  end

end

private

def group_params

  params.require(:group).permit(:name, {user_ids:[]})
end

def set_group
  @group = Group.find(params[:id])
end

end
