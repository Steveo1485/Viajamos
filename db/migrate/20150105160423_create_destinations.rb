class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.integer :trip_id
      t.integer :location_id
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
