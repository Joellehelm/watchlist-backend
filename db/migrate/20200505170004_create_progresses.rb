class CreateProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :progresses do |t|
      t.integer :user_id
      t.integer :show_id
      t.integer :season_id
      t.integer :episode_id
      t.timestamps
    end
  end
end
