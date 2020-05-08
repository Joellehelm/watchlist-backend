class Episode < ApplicationRecord
    belongs_to :season, dependent: :destroy
end
