class AddRequestSentToFacebookConnections < ActiveRecord::Migration
  def change
    add_column :facebook_connections, :request_sent, :boolean, default: false
  end
end
