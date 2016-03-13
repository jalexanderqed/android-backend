class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.text :comment
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
