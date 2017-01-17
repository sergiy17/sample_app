class UsersController < ApplicationController
	before_action :logged_in_user, only: [ :edit, :update, :index, :destroy ]
	before_action :correct_user, only: [ :edit, :update ]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render "new"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Successfully updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:danger] = "User deleted"
		redirect_to users_path
	end

	private
	
	def user_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation) 
	end

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Pleace log in"
			redirect_to login_path
		end
	end

	#Confirm correct user
	def correct_user
		@user = User.find(params[:id])
		redirect_to root_path unless @user == correct_user?(@user)
	end

end
