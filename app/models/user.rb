class User < ApplicationRecord
	validates :name, presence: true
	attr_accessor :password, :password_confirmation
	# validates :name,  presence: true
end
