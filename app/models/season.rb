class Season < ApplicationRecord
    belongs_to :show, dependent: :destroy
    has_many :episodes
end
