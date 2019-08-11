class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :indicate_twitter, :boolean, default: false, null: false
  end
end
