class ProgressesController < ApplicationController
    before_action :authorized
    
    def index
        progresses = Progress.all
        render json: progresses
    end

    def show
        show = Show.find_by(imdbID: params[:id])
        progress = Progress.where(:user_id => params[:user_id], :show_id => show.id).to_json(progress_serializer)
     
        render json: progress
    end 

    def create
        new_progress = Progress.create(progress_params)
        render json: new_progress
    end

    def destroy
        render json: Progress.find(params[:id]).destroy
    end

    def update
        progress = Progress.find(params[:id]).update(progress_params)
        render json: progress
    end


    private

    def progress_params
        params.require(:progress).permit(:user_id, :show_id, :season_id, :episode_id)
    end

    def progress_serializer
        {
            :only => [:id, :user_id, :show_id, :season_id, :episode_id],

            :include => {:season => {}, :episode => {}, :show => {}}
            
        }
    end


  
end