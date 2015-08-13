class RemveDefaultFromDesinationsDayOffset < ActiveRecord::Migration
  def change
    change_column :destinations, :day_offset, :integer, default: nil
    change_column :destinations, :day_offset, :integer, null: false
  end
end
