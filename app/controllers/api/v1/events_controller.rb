class Api::V1::EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    @events = Event.all
    if params[:date].present?
      date = Date.parse params[:date]
      @events = @events.actual_for date
    end
    render
  end

  # TODO убрать??
  def show
    render
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      render :show, status: :created
    else
      render json: {errors: @event.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render :show, status: :ok
    else
      render json: {errors: @event.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      head :no_content
    else
      render json: {errors: @event.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(
        :start_date,
        :end_date,
        {info: AVAILABLE_LOCALES},
        :sport_id,
        :location_id
      )
    end
end
