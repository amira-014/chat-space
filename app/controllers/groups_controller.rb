class GroupsController < ApplicationController
before_action :check_signed_in
  def index
    @name = current_user.name
  end

  private
  def check_signed_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
