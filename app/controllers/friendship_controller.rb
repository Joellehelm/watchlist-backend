class FriendshipController < ApplicationController
    before_action :authorized
    
    def index
        friendships = Friendship.all
        render json: friendships
    end

    def friendship
        render json: Friendship.find(params['id'])
    end 

    def create
        new_friendship = Friendship.create(friendship_params)
        render json: new_friendship
    end

    def destroy
        render json: Friendship.find(params['id']).destroy
    end

    def update
        friendship = Friendship.find(params['id']).update(friendship_params)
        render json: friendship
    end


    private

    def friendship_params
        params.require(:friendship).permit(:receiver_id, :sender_id)
    end

    
    def friendship_serializer
        {
          
        }
    end
end
