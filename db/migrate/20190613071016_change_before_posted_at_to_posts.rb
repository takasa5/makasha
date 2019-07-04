class ChangeBeforePostedAtToPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :before_posted_at
    add_column :posts, :period_before, :integer
    # rename_column :posts, :before_posted_at, :period_before
    # change_column :posts, :period_before, 'integer USING CAST(period_before AS integer)'
  end
end
