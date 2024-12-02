class UpdateShowJob < ApplicationJob
  queue_as :default

  def perform(show, update_type, season = nil)
    update_show_info(show) if update_type == 'info'
    update_season(show, season) if update_type == 'season'
  end

  def update_show_info(show)
    url = URI.parse("http://www.omdbapi.com/?apikey=#{ENV["API_KEY"]}&i=#{show.imdbID}")

    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
    }

    res_body = JSON(res.body)
    season_count = res_body["totalSeasons"].to_i

    show.year = res_body["Year"]
    show.imdbRating = res_body["imdbRating"]
    show.awards = res_body["Awards"]
    show.poster = res_body["Poster"]

    if show.seasons.count != season_count
      missing_seasons = season_count - show.seasons.count
      add_missing_seasons(show, missing_seasons)
    end

    show.total_seasons = season_count

    show.save!
  end

  def add_missing_seasons(show, missing_seasons)

    season_n = show.seasons.last.season_number + 1
  
    missing_seasons.times do |i|
      new_season = Season.create!(season_number: season_n, show_id: show.id )

      url = URI.parse("http://www.omdbapi.com/?apikey=#{ENV["API_KEY"]}&i=#{show.imdbID}&Season=#{new_season.season_number}")

      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
      }
      JSON(res.body)["Episodes"].each do |episode|
        
          Episode.create!(season_id: new_season.id, episode_num: episode["Episode"], title: episode["Title"], released: episode["Released"], imdbRating: episode["imdbRating"], imdbID: episode["imdbID"])
      end

      season_n += 1
    end
  end

  def update_season(show, season)
    url = URI.parse("http://www.omdbapi.com/?apikey=#{ENV["API_KEY"]}&i=#{show.imdbID}&Season=#{season.season_number}")

      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
      }
      JSON(res.body)["Episodes"].each do |episode|
        
          current_episode = Episode.find_by(imdbID: episode["imdbID"])

          if current_episode
            current_episode.update!(title: episode["Title"], released: episode["Released"], imdbRating: episode["imdbRating"])
          else
            Episode.create!(season_id: season.id, episode_num: episode["Episode"], title: episode["Title"], released: episode["Released"], imdbRating: episode["imdbRating"], imdbID: episode["imdbID"])
          end
      end
  end

end
