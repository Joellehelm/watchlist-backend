class ProgressController < ApplicationController
    before_action :authorized
    
    def index
        progresses = Progress.all
        render json: progresses
    end

    def progress
        render json: Progress.find(params['id'])
    end 

    def create
        new_progress = Progress.create(progress_params)
        render json: new_progress
    end

    def destroy
        render json: Progress.find(params['id']).destroy
    end

    def update
        progress = Progress.find(params['id']).update(progress_params)
        render json: progress
    end


    private

    def progress_params
        params.require(:progress).permit(:user_id, :show_id, :season_id, :episode_id)
    end

    def progress_serializer
        {
          
        }
    end
end
