class Api::V1::UsersController < Api::ApiController
  skip_before_action :require_login, only: [:signin]
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
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
    if @user = login(user_params[:email], user_params[:password])
      # generate token
      info = {user_agent: request.user_agent}
      auth = @user.authentications.create info: info
      # render token
      @auth_token = encode_auth_token auth
    else
      render json: {errors: ['Неверные email или пароль']}, status: :unauthorized
    end
  end

  def signout
    logout
    head :no_content
  end

  # DELETE /auth/tokens
  # def destroy_token
  #   if params[:token] == 'current'
  #     @auth = current_auth_by_token
  #     @auth.destroy
  #     head :no_content
  #   elsif params[:token] == 'other'
  #     @auths = current_user.authentications.where.not(id: current_auth_by_token.id)
  #     @auths.destroy_all
  #     head :no_content
  #   else
  #     render json: {errors: ['Invalid parameter']}, status: :unprocessable_entity
  #   end
  # end

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
