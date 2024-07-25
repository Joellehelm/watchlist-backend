class ShowsController < ApplicationController
  before_action :authorized

  def index
    shows = Show.all
    render json: shows.to_json(shows_serializer)
  end

  def show
    user = current_user

    show = Show.find_by(imdbID: params[:id])
    user_show = user.user_shows.find_by(show_id: show.id)

    render json: {show: ShowSerializer.new(show), user_show: user_show}
  end 

  def create
    user = current_user
    imdb_show = Show.find_by(imdbID: shows_params[:imdbID])

    show = imdb_show ? imdb_show : create_new_show

    if !user.shows.include?(show)
      UserShow.create(user_id: user.id, show_id: show.id)
    end

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

  def create_new_show
    new_show = Show.create(shows_params)
    Show.create_seasons(shows_params[:total_seasons], shows_params[:imdbID], new_show.id)
    new_show
  end

  def shows_params
    params.require(:show).permit(:name, :poster, :genre, :total_seasons, :imdbID, :movie_or_show, :year, :imdbRating, :plot, :awards, :actors)
  end


  def shows_serializer
    {
      :include => {:seasons => {
        :include => {:episodes => {}}
      }}
    }
  end
end
