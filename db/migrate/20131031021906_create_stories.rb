class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :twitter_handle, :null=>false
      t.string :my_story, :null=>false
      t.string :profile_image_url, :null=>false
      t.timestamps
    end
  end
end
