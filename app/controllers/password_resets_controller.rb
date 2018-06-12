class PasswordResetsController < ApplicationController
  before_action :take_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".sent_email"
      redirect_to root_url
    else
      flash.now[:danger] = t ".not_found_email"
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add password: t(".not_empty_pass")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t ".flash_reset_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def take_user
    @user = User.find_by email: params[:email]
    invalid_user if @user.nil
  end

  def valid_user
    redial_root unless @user.activated? && @user.authenticated?(:reset, params[:id])
  end

  def check_expiration
    link_expire if @user.password_reset_expired?
  end

  def link_expire
    flash[:danger] = t "flash_expire_pass_reset"
    redirect_to new_password_reset_path
  end

  def invalid_user
    flash.now[:danger] = t "user_nil"
    render :new
  end

  def redial_root
    flash.now[:danger] = t "user_nil"
    redirect_to root_path
  end
end
