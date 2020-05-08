class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :season_number
      t.integer :show_id
      t.timestamps
    end
  end
end
