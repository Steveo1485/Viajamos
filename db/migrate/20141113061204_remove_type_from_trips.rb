class RemoveTypeFromTrips < ActiveRecord::Migration
  def change
    remove_column(:trips, :type)
  end
end
