class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  		@user.create_password_reset_digest
  		@user.send_password_reset_email
  		flash[:info] = "Check your email, faggot!"
  		redirect_to root_path
  	else
  		flash.now[:danger] = "Email address not found"
  		redirect_to 'new'
  	end
  end

  def edit
  end

  def update
    if @user.params[:user][:password].empty?
      @user.errors.add(:password, "Password is empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:password,:password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_path
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset hed expired"
      redirect_to root_path
    end
  end
end
