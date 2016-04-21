class Api::V1::EventsController < Api::ApiController
  # before_action :set_location, only: [:index, :create]
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    # @events = @location.events
    @events = Event.all
  end

  def show
  end

  # def create
  #   @event = @location.events.new(event_params)

  #   if @event.save
  #     render :show, status: :created
  #   else
  #     render json: {errors: @event.errors}, status: :unprocessable_entity
  #   end
  # end

  def update
    @event = Event.find(params[:id])

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

    # def set_location
    #   @location = Location.find(params[:location_id])
    # end

    def event_params
      params.require(:event).permit(
        :start_date,
        :end_date,
        {info: AVAILABLE_LOCALES},
        :sport_id
      )
    end
end
