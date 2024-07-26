class UserShowsController < ApplicationController
    before_action :authorized

    def destroy
        render json: UserShow.find(params[:id]).destroy
    end

end
