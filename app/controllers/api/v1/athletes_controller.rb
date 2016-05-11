class Api::V1::AthletesController < ApplicationController
  before_action :set_country, only: [:index, :create]
  before_action :set_athlete, only: [:show, :update, :destroy]

  def index
    @athletes = @country.athletes.page(params[:page])
  end

  def show
    @published_contests = @athlete.contests.published.includes(:participations)
  end

  def create
    @athlete = @country.athletes.new(athlete_params)

    if @athlete.save
      render :show, status: :created
    else
      render json: {errors: @athlete.errors}, status: :unprocessable_entity
    end
  end

  def update
    @athlete = Athlete.find(params[:id])

    if @athlete.update(athlete_params)
      render :show, status: :ok
    else
      render json: {errors: @athlete.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @athlete.destroy
      head :no_content
    else
      render json: {errors: @athlete.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_athlete
      @athlete = Athlete.find(params[:id])
    end

    def set_country
      @country = Country.find(params[:country_id])
    end

    def athlete_params
      params.require(:athlete).permit(
        {name: AVAILABLE_LOCALES},
        {info: AVAILABLE_LOCALES},
        :photo
      )
    end
end
