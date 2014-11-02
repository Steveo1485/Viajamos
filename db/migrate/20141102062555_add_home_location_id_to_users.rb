class AddHomeLocationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_location_id, :integer
    add_index(:users, :home_location_id)
  end
end
