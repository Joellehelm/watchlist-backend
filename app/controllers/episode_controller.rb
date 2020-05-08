class EpisodeController < ApplicationController

    def index
        episodes = Episode.all
        render json: episodes
    end

    def episode
        render json: Episode.find(params['id'])
    end 

    def create
        new_episode = Episode.create(episode_params)
        render json: new_episode
    end

    def destroy
        render json: Episode.find(params['id']).destroy
    end

    def update
        episode = Episode.find(params['id']).update(episode_params)
        render json: episode
    end


    private

    def episode_params
        params.require(:episode).permit(:user_id, :show_id, :season_id, :episode_id)
    end

    def episode_serializer
        {
          
        }
    end
end
