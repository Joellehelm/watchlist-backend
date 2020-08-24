class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :genre
      t.string :poster
      t.string :total_seasons
      t.string :imdbID
      t.string :movie_or_show
      t.string :year
      t.string :imdbRating
      t.string :actors
      t.string :awards
      t.string :plot
      t.timestamps
    end
  end
end
