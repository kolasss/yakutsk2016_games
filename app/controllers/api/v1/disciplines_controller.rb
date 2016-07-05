class Api::V1::DisciplinesController < ApplicationController
  before_action :set_sport, only: [:index, :create]
  before_action :set_discipline, only: [:show, :update, :destroy]

  def index
    @disciplines = @sport.disciplines
    render
  end

  def show
    render
  end

  def create
    @discipline = @sport.disciplines.new(discipline_params)

    if @discipline.save
      render :show, status: :created
    else
      render json: {errors: @discipline.errors}, status: :unprocessable_entity
    end
  end

  def update
    @discipline = Discipline.find(params[:id])

    if @discipline.update(discipline_params)
      render :show, status: :ok
    else
      render json: {errors: @discipline.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @discipline.destroy
      head :no_content
    else
      render json: {errors: @discipline.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_discipline
      @discipline = Discipline.find(params[:id])
    end

    def set_sport
      @sport = Sport.find(params[:sport_id])
    end

    def discipline_params
      params.require(:discipline).permit(
        {name: AVAILABLE_LOCALES},
        :finished,
        :unit
      )
    end
end
