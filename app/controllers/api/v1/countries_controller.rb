class Api::V1::CountriesController < Api::ApiController
  before_action :set_country, only: [:show, :update, :destroy]

  def index
    @countries = Country.all
  end

  def show
    @published_contests = @country.contests.published.includes(:participations)
    @events = @country.events
    if params[:date].present?
      date = Date.parse params[:date]
      @events = @events.actual_for date
    end
  end

  def create
    @country = Country.new(country_params)

    if @country.save
      render :show, status: :created
    else
      render json: {errors: @country.errors}, status: :unprocessable_entity
    end
  end

  def update
    @country = Country.find(params[:id])

    if @country.update(country_params)
      render :show, status: :ok
    else
      render json: {errors: @country.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @country.destroy
      head :no_content
    else
      render json: {errors: @country.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.require(:country).permit(
        {name: AVAILABLE_LOCALES},
        {info: AVAILABLE_LOCALES},
        :flag
      )
    end
end
