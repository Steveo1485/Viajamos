class FriendshipsConfirmedFalseDefault < ActiveRecord::Migration
  def change
    change_column :friendships, :confirmed, :boolean, default: false
  end
end
