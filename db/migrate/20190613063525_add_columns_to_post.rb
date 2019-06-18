class AddColumnsToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :count, :integer
    add_column :posts, :before_posted_at, :datetime
  end
end
