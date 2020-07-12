class ShowsController < ApplicationController
    before_action :authorized
    
    def index
        shows = Show.all
        render json: shows.to_json(shows_serializer)
    end

    def show
        render json: Show.find(params['id']).to_json(shows_serializer)
    end 

    def create
        if Show.find_by(imdbID: params[:imdbID])
            show = Show.find_by(imdbID: params[:imdbID])
            UserShow.create(user_id: params[:user_id], show_id: show.id)
            render json: show
        else
            new_show = Show.create(shows_params)
            UserShow.create(user_id: params[:user_id], show_id: new_show.id)
            Show.create_seasons(params[:total_seasons], params[:imdbID], new_show.id)
            render json: new_show
        end
    end

    def show_by_imdbID
        show = Show.find_by(imdbID: params[:imdbID])
        render json: show
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
        params.require(:show).permit(:name, :poster, :genre, :total_seasons, :user_id, :imdbID, :movie_or_show, :year, :imdbRating, :plot, :awards, :actors)
    end


    def shows_serializer
        {
          
        }
    end
end
