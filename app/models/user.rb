class User < ApplicationRecord
    has_secure_password
    has_many :user_shows, dependent: :destroy
    has_many :shows, through: :user_shows
    has_many :progresses, dependent: :destroy

    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships

    has_many :suggestions, dependent: :destroy
    
    has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'    
    has_many :received_friends, through: :received_friendships, source: 'User'
    
    validates :username, :email, uniqueness: { case_sensitive: false }
  

    

def current_friends
  friends.select{ |friend| friend.friends.include?(self) }  
end

def pending_friends
  friends.select{ |friend| !friend.friends.include?(self) }  
end



end
