class ShowsController < ApplicationController
    before_action :authorized
    
    def index
        shows = Show.all
        render json: shows.to_json(shows_serializer)
    end

    def show
        user = current_user()
       
        show = Show.find_by(imdbID: params[:id])
        user_show = user.user_shows.find_by(show_id: show.id)

        render json: {show: ShowSerializer.new(show), user_show: user_show}
    end 

    def create
        user = current_user()
        if Show.find_by(imdbID: params[:imdbID])
            show = Show.find_by(imdbID: params[:imdbID])
            if !user.shows.include?(show)
                UserShow.create(user_id: params[:user_id], show_id: show.id)
                render json: show
            end
        else
            new_show = Show.create(shows_params)
            UserShow.create(user_id: params[:user_id], show_id: new_show.id)
            Show.create_seasons(params[:total_seasons], params[:imdbID], new_show.id)
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
        params.require(:show).permit(:name, :poster, :genre, :total_seasons, :user_id, :imdbID, :movie_or_show, :year, :imdbRating, :plot, :awards, :actors)
    end


    def shows_serializer
        {
          :include => {:seasons => {
              :include => {:episodes => {}}
          }}
        }
    end
end
