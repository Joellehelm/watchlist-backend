require 'net/http'

class Show < ApplicationRecord
    has_many :seasons, dependent: :destroy
    has_many :episodes, :through => :seasons
    has_one :progress
    has_many :user_shows
    validates :imdbID, uniqueness: { case_sensitive: false }
   


    def self.create_seasons(num_of_seasons, show_imdbID, show_id)
  
  
        num_of_seasons.to_i.times do |i|
            season_n = i + 1
            new_season = Season.create(season_number: season_n, show_id: show_id )
      
            url = URI.parse("http://www.omdbapi.com/?apikey=#{ENV["API_KEY"]}&i=#{show_imdbID}&Season=#{new_season.season_number}")
    
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
            }
            # puts JSON(res.body)["Episodes"]
            JSON(res.body)["Episodes"].each_with_index do |episode, idx|
              
                ep_num = idx + 1
                Episode.create(season_id: new_season.id, episode_num: ep_num, title: episode["Title"], released: episode["Released"], imdbRating: episode["imdbRating"], imdbID: episode["imdbID"])
            end
        end 


    # url = URI.parse("http://www.omdbapi.com/?apikey=22bc310a&i=tt0944947&Season=#{season_num}")
    # req = Net::HTTP::Get.new(url.to_s)
    # res = Net::HTTP.start(url.host, url.port) {|http|
    #   http.request(req)
    # }
    # puts "================================="
    # puts res.body
    end

end
