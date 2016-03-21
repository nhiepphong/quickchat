class SessionsController < ApplicationController
  def new
  	
  end
  
  def create
  	if session[:user_id]
  		redirect_to users_path
  	else
    	if @user = User.find_by(email:params[:email]) and @user.authenticate(params[:password])
    		session[:user_id] = @user.id
    		redirect_to users_path, flash: {success: "Logged in"}
    	else
    		flash.now[:error] = "Invalid email or Password "
    		render 'new'
    	end
    end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path	
  end
end
