class CreateVisitedCountries < ActiveRecord::Migration
  def change
    create_table :visited_countries do |t|
      t.string :name
      t.integer :year
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
