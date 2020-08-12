class UserShowsController < ApplicationController
    before_action :authorized

    def index
        usershows = UserShow.all
        render json: usershows
    end

    def show
        render json: UserShow.find(params['id'])
    end 

    def create
        new_usershow = UserShow.create(usershows_params)
        render json: new_usershow
    end

    def destroy
        render json: UserShow.find(params['id']).destroy
    end

    def update
        usershow = UserShow.find(params['id']).update(usershows_params)
        render json: usershow
    end

  

    private

    def usershows_params
        params.require(:usershow).permit(:user_id, :show_id)
    end

    def usershows_serializer
       
    end
end
