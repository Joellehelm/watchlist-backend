class Show < ApplicationRecord
    has_many :seasons
    has_many :episodes, :through => :seasons
    has_one :progress
    has_many :user_shows
    validates :name, uniqueness: { case_sensitive: false }

end
