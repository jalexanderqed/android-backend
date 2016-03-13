class MakeUsernameUnique < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, :unique => false
  end
end
