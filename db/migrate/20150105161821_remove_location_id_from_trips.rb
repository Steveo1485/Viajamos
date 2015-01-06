class RemoveLocationIdFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :location_id, :integer
    remove_column :trips, :start_date, :date
    remove_column :trips, :end_date, :date
  end
end
