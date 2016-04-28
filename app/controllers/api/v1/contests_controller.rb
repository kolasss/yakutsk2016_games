class Api::V1::ContestsController < Api::ApiController
  before_action :set_discipline, only: [:index, :create]
  before_action :set_contest, only: [:show, :update, :destroy]

  def index
    @contests = @discipline.contests
  end

  def show
  end

  def create
    @contest = @discipline.contests.new(contest_params)

    if @contest.save
      render :show, status: :created
    else
      render json: {errors: @contest.errors}, status: :unprocessable_entity
    end
  end

  def update
    @contest = Contest.find(params[:id])

    if @contest.update(contest_params)
      render :show, status: :ok
    else
      render json: {errors: @contest.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @contest.destroy
      head :no_content
    else
      render json: {errors: @contest.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_contest
      @contest = Contest.find(params[:id])
    end

    def set_discipline
      @discipline = Discipline.find(params[:discipline_id])
    end

    def contest_params
      params.require(:contest).permit(
        {name: AVAILABLE_LOCALES},
        :start_at,
        :published_at,
        participations_attributes: [
          :id,
          :score,
          :rank,
          :team_id,
          :_destroy
        ]
      )
    end
end
