class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.integer :season_id
      t.string :released
      t.integer :episode_num
      t.integer :imdbRating
      t.string :imdbID
      t.timestamps
    end
  end
end
