class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_user, except: %i(index new create)

  def show; end

  def edit; end

  def index
    @users = User.paginate page: params[:page], per_page: Settings.item_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "active_mail_info"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".flash_update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = @user.destroy ? t(".flash_destroy_success") : flash[:danger] = t(".flash_destroy_failed")
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:danger] = t ".user_nil"
    redirect_to root_path
  end
end
