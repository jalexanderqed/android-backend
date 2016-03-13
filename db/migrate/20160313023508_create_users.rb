class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null:false
      t.string :password, null:false
      t.string :real_name, null:false
      t.integer :birth_year, null:false
      t.integer :birth_month, null:false
      t.integer :birth_day, null:false
      t.text :bio

      t.timestamps null: false
    end
  end
end
