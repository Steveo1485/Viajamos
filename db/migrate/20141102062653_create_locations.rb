class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state_code
      t.string :country_code
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
