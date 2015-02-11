class AddIgnoreToFacebookConnections < ActiveRecord::Migration
  def change
    add_column :facebook_connections, :ignore, :boolean, default: false
  end
end
