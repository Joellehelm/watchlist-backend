class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
   
    def index
      users = User.all
      if users
        render json: {users: serialize_user(user)}
      else
        render json: {status: 500, errors: ['no users found']}
      end
  end
  
  
  def show
      user = User.find(params[:id])
     if user
        render json: {user: serialize_user(user)}
      else
        render json: {status: 500, errors: ['user not found']}
      end
    end
    

    def create
      if params[:password] == params[:password_confirmation]
        user = User.create(user_params)
        if user.valid?
          token = encode_token({ user_id: user.id })
        
          UserMailer.with(user: UserSerializer.new(user)).welcome_email.deliver_now!
     
          render json: { user: UserSerializer.new(user), jwt: token, status: :created}
        else
          render json: { error: user.errors, status: :not_acceptable}
        end
      end
    end

    def update
      user = current_user()

      if user.authenticate(params[:password])
        user.update(user_params)
        render json: {user: user, updated: true}
      else
        render json: {user: user, updated: false}
      end
    end

    def update_password
      user = current_user()

      if user.authenticate(params[:user][:password])
        user.update(password: params[:user][:new_password])
        render json: {user: user, updated: true}
      else 
        render json: {user: user, updated: false}
      end
    end
  
    def watchlist
      render json: current_user().to_json(watchlist_serializer)
    end

    def show_in_watchlist
      user = current_user()

      if user.shows.find_by(imdbID: params[:imdbID])
        render json: true
      else
        render json: false
      end
      
    end

  private
    
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def watchlist_serializer
      {
        :only => [:id, :username, :email],

        :include => {:shows => {
            :include => {:seasons => {
              :include => {:episodes => {}}
            }}
        }} 
    }
    end
  
    
  end