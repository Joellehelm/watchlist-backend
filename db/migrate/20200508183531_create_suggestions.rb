class CreateSuggestions < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestions do |t|
      t.integer :suggester_id
      t.integer :user_id
      t.integer :show_id
      t.timestamps
    end
  end
end
