class HomeController < ApplicationController
  def index
    if current_user
      @all_users = current_user.followings
      unless @all_users.include?(current_user)
        @all_users.push(current_user)
      end
      @posts = Post.where(:user_id => @all_users).order(created_at: :desc).page(params[:page]).per(5)
      
    else
      redirect_to new_user_session_path
    end
  end
end
