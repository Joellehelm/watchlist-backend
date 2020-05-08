class Suggestion < ApplicationRecord
    belongs_to :user
    belongs_to :show
    belongs_to :suggester, class_name: "User"

    validates_presence_of :user_id, :suggester_id, :show_id
end
