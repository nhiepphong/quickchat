class UsersController < ApplicationController
  
  def new
  	if session[:user_id]
  		redirect_to user_path
  	else
    	@user = User.new
    end
  end

  def index
    #@users = User.all.shuffle
    @users = User.where.not(id: current_user.id).shuffle
  end

  def create
  	@user = User.create user_params
  	if @user.persisted?
  		session[:user_id] = @user.id
  		redirect_to users_path, flash: {success: "Register successfully!"}
  	else
  		flash.now[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
  		render 'new'
  	end
  end

  def add_friend
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
    redirect_to users_path
  end

  def remove_friend
    Friendship.where(user_id: current_user.id, friend_id: params[:friend_id]).delete_all
    Friendship.where(friend_id: current_user.id, user_id: params[:friend_id]).delete_all
    redirect_to users_path
  end

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_url)
  end

end
