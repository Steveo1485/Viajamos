class RemoveNullFalseFromTripsStartAndEndDate < ActiveRecord::Migration
  def change
    change_column_null :trips, :start_date, :true
    change_column_null :trips, :end_date, :true
  end
end
