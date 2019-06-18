class AddTwitteridToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitterid, :string
  end
end
