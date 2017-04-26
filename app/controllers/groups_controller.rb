class GroupsController < ApplicationController
before_filter :authenticate_user!

  def index
    @user = current_user
    @groups = Group.all
  end

  def show
    @user = current_user
    @users = User.all
    @group = Group.find(params[:id])
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
  if @group.save
    redirect_to group_path(@group[:id]), notice: 'グループが作成されました'
  else
    redirect_to new_group_path, alert: 'グループの作成に失敗しました'
  end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group[:id]), notice: 'グループが編集されました'
    else
      redirect_to edit_group_path, alert: 'グループの編集に失敗しました'
    end
  end

private
  def group_params
    params.require(:group).permit(:name, {user_ids:[]})
  end
end
