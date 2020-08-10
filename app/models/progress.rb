class Progress < ApplicationRecord
    belongs_to :user
    belongs_to :show
    belongs_to :episode
    belongs_to :season

    
end
