class Users::SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(user_params[:email], user_params[:password], true)
      redirect_back_or_to(root_path, notice: 'Вход в систему выполнен.')
    else
      flash.now[:alert] = 'Неверные email или пароль.'
      @user = User.new user_params
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Выход из системы выполнен.')
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end
end
