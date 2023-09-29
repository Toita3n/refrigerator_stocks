class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create update]

  def new
    @sign_up_form = SignUpForm.new
  end

  def create
    @sign_up_form = SignUpForm.new(sign_up_form_params) #form_objectを使用してユーザー登録
    if @sign_up_form.save
      redirect_to login_path, success: 'サインアップしました'
    else
      flash.now[:danger] = 'サインアップに失敗しました'
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    @user.destroy!
    redirect_to root_path
  end

  private

  def sign_up_form_params
    params.require(:sign_up_form).permit(:email, :password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
end
