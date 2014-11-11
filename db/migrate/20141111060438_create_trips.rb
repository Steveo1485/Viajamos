class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :location_id, null: false
      t.integer :user_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :purpose
      t.boolean :private, default: false
      t.boolean :busy, default: false
      t.timestamps
    end
    add_index(:trips, :location_id)
    add_index(:trips, :user_id)
  end
end
