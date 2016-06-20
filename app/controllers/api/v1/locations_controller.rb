class Api::V1::LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]

  def index
    @locations = Location.all
    render
  end

  def show
    @events = @location.events
    render
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      render :show, status: :created
    else
      render json: {errors: @location.errors}, status: :unprocessable_entity
    end
  end

  def update
    @location = Location.find(params[:id])

    if @location.update(location_params)
      render :show, status: :ok
    else
      render json: {errors: @location.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @location.destroy
      head :no_content
    else
      render json: {errors: @location.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(
        {name: AVAILABLE_LOCALES},
        {address: AVAILABLE_LOCALES},
        {info: AVAILABLE_LOCALES},
        :photo,
        :sport
      )
    end
end
