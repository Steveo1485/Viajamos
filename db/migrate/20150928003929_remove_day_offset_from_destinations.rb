class RemoveDayOffsetFromDestinations < ActiveRecord::Migration
  def change
    remove_column :destinations, :day_offset
  end
end
