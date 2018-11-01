class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.string :next_episode
      t.integer :user_id
    end
  end
end
