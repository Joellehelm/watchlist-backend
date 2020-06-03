class ShowController < ApplicationController
    before_action :authorized
    
    def index
        shows = Show.all
        render json: shows.to_json(shows_serializer)
    end

    def show
        render json: Show.find(params['id']).to_json(shows_serializer)
    end 

    def create
        if Show.find(shows_params[:name])
            show = Show.find(shows_params[:name])
            User_Show.create(user_id: shows_params[:user_id], show_id: show.id)
            render json: show
        else
            new_show = Show.create(shows_params)
            user_show = UserShow.create(user_id: shows_params[:user_id], show_id: new_show.id)
            render json: new_show
        end
    end

    def destroy
        render json: Show.find(params['id']).destroy
    end

    def update
        show = Show.find(params['id']).update(shows_params)
        render json: show
    end


    private

    def shows_params
        params.require(:show).permit(:name, :poster, :genre, :total_seasons, :user_id)
    end

    def shows_serializer
        {
          
        }
    end
end
