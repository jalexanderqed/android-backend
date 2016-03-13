class ActuallyMakeUsernameUnique < ActiveRecord::Migration
  def change
    execute <<-SQL
      alter table users
        add constraint unique_username unique (username);
    SQL
  end
end
