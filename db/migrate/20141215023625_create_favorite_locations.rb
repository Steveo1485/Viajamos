class CreateFavoriteLocations < ActiveRecord::Migration
  def change
    create_table :favorite_locations do |t|
      t.integer :user_id
      t.integer :location_id
      t.timestamps
    end
  end
end
