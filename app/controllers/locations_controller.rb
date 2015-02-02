class LocationsController < ApplicationController
  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 1, :units => :km,  :order => :distance)
    else
      @locations = Location.all
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def location_params
    params.require(:location).permit(:name, :address, :latitude, :longitude)
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location, :notice => "Successfully created location."
    else
      render :action => 'new'
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      redirect_to @location, :notice  => "Successfully updated location."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to locations_url, :notice => "Successfully destroyed location."
  end

  def get_autho
  	render json: authenticity_token
  end

  def get_data
    @locations = Location.all
    # @location = @location.nearbys(10, :units => :km)   
    render json: @locations
  end

  def get_data_from_my_position
    @locations = Location.all
    @locations = @locations.near([params[:latitude], params[:longitude]], 5, :units => :km)
    render json: @locations
  end

  skip_before_action :verify_authenticity_token, :only => [:get_data, :get_data_from_my_position]
end
