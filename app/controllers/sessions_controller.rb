class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_to user_path(user)
			flash[:success] = "You passed the authentication!"
		else
			flash[:danger] = "Your password or email is wrong"
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_path
	end
end