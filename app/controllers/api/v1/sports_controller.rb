class Api::V1::SportsController < Api::ApiController
  before_action :set_sport, only: [:show, :update, :destroy]

  def index
    @sports = Sport.all
  end

  def show
    @published_contests = @sport.contests.published.includes(:participations)
    @disciplines = @sport.disciplines.includes(contests: [:participations])
  end

  def create
    @sport = Sport.new(sport_params)

    if @sport.save
      render :show, status: :created
    else
      render json: {errors: @sport.errors}, status: :unprocessable_entity
    end
  end

  def update
    @sport = Sport.find(params[:id])

    if @sport.update(sport_params)
      render :show, status: :ok
    else
      render json: {errors: @sport.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @sport.destroy
      head :no_content
    else
      render json: {errors: @sport.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_sport
      @sport = Sport.find(params[:id])
    end

    def sport_params
      params.require(:sport).permit(
        {name: AVAILABLE_LOCALES},
        {info: AVAILABLE_LOCALES},
        :icon
      )
    end
end
