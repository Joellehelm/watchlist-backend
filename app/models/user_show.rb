class UserShow < ApplicationRecord
    belongs_to :show
    belongs_to :user
    validates :show, uniqueness: { scope: :user,
    message: "A show can only be added to a watchlist once." }
end
