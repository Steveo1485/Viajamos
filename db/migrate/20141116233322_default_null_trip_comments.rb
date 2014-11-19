class DefaultNullTripComments < ActiveRecord::Migration
  def change
    change_column_default :trips, :comments, nil
  end
end
