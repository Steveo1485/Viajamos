class TripsController < ApplicationController
  before_filter :fetch_trip, only: [:edit, :update]

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

  def edit
    authorize(@trip)
  end

  def update
    authorize(@trip)
    if @trip.update(trip_params)
      redirect_to user_root_path
    else
      render :edit
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

  def fetch_trip
    @trip = Trip.find(params[:id])
  end

end
