class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user && @user.authenticate(params[:session][:password])
      checkin
    else
      invalid_checkin
    end
  end

  def checkin
    if @user.activated?
      log_in @user
      params[:session][:remember_me] ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash[:warning] = t "flash_acc_not_actived"
      redirect_to root_path
    end
  end

  def invalid_checkin
    flash.now[:danger] = t ".flash_invalid_danger"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
