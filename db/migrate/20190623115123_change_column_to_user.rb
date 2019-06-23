class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :template, :string, default: "%song% - %artist%"
  end
end
