class Api::V1::UsersController < ApplicationController
  skip_before_action :require_login, only: [:signin]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render
  end

  def show
    render
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      head :no_content
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  def signin
    @user = User.find_by email: user_params[:email]

    if @user && @user.valid_password?(user_params[:password])
      # generate token
      info = {user_agent: request.user_agent}
      auth = @user.authentications.create info: info
      # render token
      @auth_token = encode_auth_token auth
      render
    else
      render json: {errors: ['Неверные email или пароль']}, status: :unauthorized
    end
  end

  def signout
    auth = current_auth_by_token
    auth.destroy
    head :no_content
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation
      )
    end
end
