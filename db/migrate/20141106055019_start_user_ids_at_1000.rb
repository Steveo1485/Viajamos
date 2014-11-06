class StartUserIdsAt1000 < ActiveRecord::Migration
  def change
    execute "ALTER TABLE users AUTO_INCREMENT = 1000;"
  end
end
