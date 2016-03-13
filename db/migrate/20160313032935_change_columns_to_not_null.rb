class ChangeColumnsToNotNull < ActiveRecord::Migration
  def change
    change_column :visited_countries, :name, :string, :null => false
    change_column :visited_countries, :year, :string, :null => false

    change_column :check_ins, :latitude, :decimal, :null => false
    change_column :check_ins, :longitude, :decimal, :null => false
  end
end
