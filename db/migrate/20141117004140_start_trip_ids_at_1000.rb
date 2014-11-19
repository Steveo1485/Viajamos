class StartTripIdsAt1000 < ActiveRecord::Migration
  def change
    execute "ALTER TABLE trips AUTO_INCREMENT = 1000;"
  end
end
