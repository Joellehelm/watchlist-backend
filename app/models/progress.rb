class Progress < ApplicationRecord
    belongs_to :user, dependent: :destroy
    belongs_to :show, dependent: :destroy
end
