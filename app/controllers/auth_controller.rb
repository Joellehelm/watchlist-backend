class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]
 
  def create
    @user = User.find_by(username: user_login_params[:username])
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
     
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def auto_login
    if current_user
      token = auth_header.split(' ')[1]
      render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
    else
      render json: {errors: "No user logged in"}
    end
  end

 
  private
 
  def user_login_params
    params.require(:user).permit(:username, :password, :token)
  end
end