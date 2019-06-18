class ChangePostedByToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :posted_by, :string 
  end
end
