class TripsController < ApplicationController

  def index
    @trips = policy_scope(Trip)
  end

  def new
    @trip = Trip.new
    authorize(@trip)
  end

  def create
    @trip = Trip.new(trip_params)
    authorize(@trip)
    if @trip.save
      redirect_to user_root_path
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:location_id,
                                 :user_id,
                                 :start_date,
                                 :end_date,
                                 :purpose,
                                 :comments,
                                 :certainty,
                                 :private,
                                 :busy)
  end

end
