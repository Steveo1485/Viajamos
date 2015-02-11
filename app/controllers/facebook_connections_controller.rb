class FacebookConnectionsController < ApplicationController

  def update
    @facebook_connection = FacebookConnection.find(params[:id])
    authorize(@facebook_connection)
    if @facebook_connection.update(facebook_connection_params)
      redirect_to root_path, notice: "Facebook Connection ignored."
    else
      redirect_to root_path, notice: "Sorry, unable to process. Please try again."
    end
  end

  private

  def facebook_connection_params
    params.require(:facebook_connection).permit(:user_id, :friend_user_id, :request_sent, :ignore)
  end
end
