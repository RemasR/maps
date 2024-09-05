class LocationsController < ApplicationController
  before_action :set_location, only: [:edit, :update, :destroy, :confirm_delete]

  def index
    @locations = Location.all
  end

  def search
    @location = Location.find_by(name: params[:name])
    if @location
      render :confirm_delete
    else
      flash[:alert] = 'Location not found.'
      redirect_to delete_by_name_path
    end
  end

  def new
    @location = Location.new
  end

  def confirm_delete
  end
  def get_info
    locations =  Location.where(id: params[:location_ids])
    info = locations.map do |location|
      { name: location.name, info: LocationsHelper.getInfo(location.address) }
    end
    render info
  end


  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to root_path, notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  def action
    case params[:action_type]
    when 'edit'
      @locations = Location.where(id: params[:location_ids])
      redirect_to edit_location_path(@locations.first) if @locations.any?
    when 'delete'
      Location.where(id: params[:location_ids]).destroy_all
      redirect_to locations_path, notice: 'Selected locations were successfully deleted.'
    else
      redirect_to locations_path, alert: 'Invalid action type.'
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to root_path, notice: 'Location was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if params[:action_type] == 'delete'
      if params[:location_ids].present?
        Location.where(id: params[:location_ids]).destroy_all
        redirect_to locations_path, notice: 'Locations were successfully deleted.'
      else
        redirect_to locations_path, alert: 'No locations selected for deletion.'
      end
    else
      redirect_to locations_path, alert: 'Invalid action type.'
    end
  end

  def delete_by_name
    @location = Location.find_by(name: params[:name])

    if @location
      @location.destroy
      flash[:notice] = 'Location was successfully deleted.'
    else
      flash[:alert] = 'Location not found.'
    end
    redirect_to locations_path
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :url)
  end
end