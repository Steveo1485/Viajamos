class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.belongs_to :user, null: false
      t.integer :friend_id, null: false
      t.string :type
      t.boolean :confirmed
      t.timestamps
    end
  end
end
