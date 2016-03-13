class RemoveYearFromVisitedCountries < ActiveRecord::Migration
  def change
    remove_column :visited_countries, :year
  end
end
