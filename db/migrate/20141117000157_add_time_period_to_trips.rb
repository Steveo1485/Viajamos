class AddTimePeriodToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :time_period, :string, default: nil
  end
end
