class UsersController < ApplicationController
  
  def new
  	if session[:user_id]
  		redirect_to user_path
  	else
    	@user = User.new
    end
  end

  def index
    @users = User.all.shuffle
  end

  def create
  	@user = User.create user_params
  	if @user.persisted?
  		session[:user_id] = @user.id
  		redirect_to users_path, flash: {success: "Register successfully!"}
  	else
  		flash.now[:error] = "Register error"
  		render 'new'
  	end
  end

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
