require 'net/http'
class Show < ApplicationRecord
    has_many :seasons
    has_many :episodes, :through => :seasons
    has_one :progress
    has_many :user_shows
    validates :name, uniqueness: { case_sensitive: false }
   


    def self.create_seasons(num_of_seasons)
        # Loop number of seasons amount of time.
        # Create a Season each time.
        # Within that loop http call to number of episodes.
        # Save each episode 
        def test
        i = 0
        10.times do
            puts "hello #{i}"
            i++
       
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
