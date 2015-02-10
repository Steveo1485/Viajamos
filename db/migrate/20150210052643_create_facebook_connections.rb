class CreateFacebookConnections < ActiveRecord::Migration
  def change
    create_table :facebook_connections do |t|
      t.integer :user_id
      t.integer :friend_user_id
      t.timestamps
    end
  end
end
