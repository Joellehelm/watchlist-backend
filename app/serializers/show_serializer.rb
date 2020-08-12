class ShowSerializer < ActiveModel::Serializer
    attributes :id, :name, :genre, :poster, :total_seasons, :imdbID, :movie_or_show, :year, :imdbRating, :actors, :awards, :plot, :seasons


    def seasons
        object.seasons.map do |season|
          SeasonSerializer.new(season, scope: scope, root: false, show: object)
        end
    end
    

end