class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
   
    def index
      @users = User.all
      if @users
        render json: {users: serialize_user(@user)}
      else
        render json: {status: 500,errors: ['no users found']}
      end
  end
  
  
  def show
      @user = User.find(params[:id])
     if @user
        render json: {user: serialize_user(@user)}
      else
        render json: {status: 500, errors: ['user not found']}
      end
    end
    

    def create
      if params[:password] == params[:password_confirmation]
        @user = User.create(user_params)
        if @user.valid?
          @token = encode_token({ user_id: @user.id })
         
          # remove password from user below before rendering json
          UserMailer.with(user: @user).welcome_email.deliver_now!
     
          render json: { user: serialize_user(@user), jwt: @token, status: :created}
        else
          render json: { error: 'failed to create user', status: :not_acceptable}
        end
      end
    end

    def update
      user = User.find(params['id']).update(user_params)
      render json: serialize_user(user)
    end
  

  private

    def serialize_user(user)
      return UserSerializer.new(user)
    end

    
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  
    
  end