class LocationsController < ApplicationController

  def search
    authorize(:location, :search?)

    respond_to do |format|
      results = Location.search(params[:q])
      format.json do
        render json: results.to_json
      end
    end
  end

end