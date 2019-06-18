class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :posted_by
      t.string :artist
      t.string :song
      t.datetime :created_at

      t.timestamps
    end
  end
end
