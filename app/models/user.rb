class User < ActiveRecord::Base
	has_secure_password

	validates :email, uniqueness: true
	validates :name, presence: true

	has_many :sent_messages, foreign_key: 'sender_id', class_name: 'Message'
	
end
