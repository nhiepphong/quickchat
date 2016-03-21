module MessageHelper
	def chat_class_name(sender_id)
		case sender_id
		when current_user.id
			"right"
		else
			"left"
		end
	end
end
