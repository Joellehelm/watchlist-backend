class SeasonController < ApplicationController
    before_action :authorized
    
    def index
        seasons = Season.all
        render json: seasons
    end

    def Season
        render json: Season.find(params['id'])
    end 

    def create
        new_season = Season.create(seasons_params)
        render json: new_season
    end

    def destroy
        render json: Season.find(params['id']).destroy
    end

    def update
        season = Season.find(params['id']).update(seasons_params)
        render json: season
    end


    private

    def seasons_params
        params.require(:season).permit(:season_number, :show_id)
    end

    def seasons_serializer
        {
          
        }
    end
end
