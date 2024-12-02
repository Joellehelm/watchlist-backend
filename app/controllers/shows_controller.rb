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

  # TODO: Remove destroy and update if unused, switch to strong params if used.

  def destroy
    render json: Show.find(params['id']).destroy
  end

  def update
    show = Show.find(params['id']).update(shows_params)
    render json: show
  end

  # TODO: Implement response message. Display something when job finishes.
  def update_show_info
    show = Show.find(show_info_params[:id])
    update_show_job = UpdateShowJob.new(show, show_info_params[:update_type])
    update_show_job.perform_now
    render json: { job_status: 'job started placeholder' }
  end

  def update_season
    season = Season.find_by(show_id: season_params[:show_id], season_number: season_params[:season_number])
    update_show_job = UpdateShowJob.new(season.show, season_params[:update_type], season)
    update_show_job.perform_now
    render json: { job_status: 'job started placeholder' }
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

  def show_info_params
    params.require(:show).permit(:id, :update_type)
  end

  def season_params
    params.require(:season).permit(:season_number, :show_id, :update_type)
  end

  def shows_serializer
    {
      :include => {:seasons => {
        :include => {:episodes => {}}
      }}
    }
  end
end
