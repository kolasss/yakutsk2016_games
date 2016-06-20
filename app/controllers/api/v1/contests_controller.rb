class Api::V1::ContestsController < ApplicationController
  before_action :set_discipline, only: [:index, :create]
  before_action :set_contest, only: [:show, :update, :destroy, :append_child, :prepend_child]

  def index
    @contests = @discipline.contests
    render
  end

  def show
    render
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

  def append_child
    child_contest = Contest.find(params[:child_id])
    sibling = @contest.children.last

    # костыль, т.к. append_child неправильно работает
    if sibling.present?
      result = sibling.append_sibling child_contest
    else
      result = @contest.append_child child_contest
    end

    if result
      head :no_content
    else
      render json: {errors: child_contest.errors}, status: :unprocessable_entity
    end
  end

  def prepend_child
    child_contest = Contest.find(params[:child_id])
    if @contest.prepend_child child_contest
      head :no_content
    else
      render json: {errors: child_contest.errors}, status: :unprocessable_entity
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
        :parent_id,
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
