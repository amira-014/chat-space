class UsersController < ApplicationController
  def search
    @users = User.search_name_with_params(user_params[:user]).where.not(id: current_user.id)
    respond_to do |format|
      format.json
    end
  end

private
  def user_params
    params.permit(:user)
  end

end
