class RemovesColumnsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :name
    remove_column :users, :email
    remove_column :users, :nickname
  end
end
