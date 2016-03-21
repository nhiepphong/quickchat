class MessageController < ApplicationController
  def index
  	if current_user
	  	if params[:friend_id]
	  		@friend = User.find(params[:friend_id])
	  		@chats = Message.where(["(recipient_id = :recipient_id and sender_id = :sender_id) OR sender_id = :recipient_id and recipient_id = :sender_id", { recipient_id: current_user.id, sender_id: params[:friend_id] }])
		else
			redirect_to users_path
		end
	else
		redirect_to root_path 
	end
  end

  def new
  	
  end

  def create
  	current_user.sent_messages.create(body: params[:content], recipient_id: params[:friend_id])
    redirect_to message_index_path(friend_id: params[:friend_id])
  end
end
