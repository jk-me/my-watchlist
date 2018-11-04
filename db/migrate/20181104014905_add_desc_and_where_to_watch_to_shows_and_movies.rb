class AddDescAndWhereToWatchToShowsAndMovies < ActiveRecord::Migration
  def change
    add_column :shows, :where_to_watch, :string
    add_column :shows, :desc, :string
    add_column :movies, :where_to_watch, :string
    add_column :movies, :desc, :string


  end
end
