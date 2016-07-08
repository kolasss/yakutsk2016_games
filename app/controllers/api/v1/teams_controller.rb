class Api::V1::TeamsController < ApplicationController
  before_action :set_country, only: [:index, :create]
  before_action :set_team, only: [:show, :update, :destroy]

  def index
    @teams = @country.teams
    render
  end

  def show
    # @athletes = @team.athletes
    data_for_show
    render
  end

  def create
    @team = @country.teams.new(team_params)

    if @team.save
      data_for_show
      render :show, status: :created
    else
      render json: {errors: @team.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      data_for_show
      render :show, status: :ok
    else
      render json: {errors: @team.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @team.destroy
      head :no_content
    else
      render json: {errors: @team.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_team
      @team = Team.find(params[:id])
    end

    def set_country
      @country = Country.find(params[:country_id])
    end

    def team_params
      params.require(:team).permit(
        {name: AVAILABLE_LOCALES},
        :discipline_id,
        :rank,
        team_memberships_attributes: [
          :id,
          :athlete_id,
          :_destroy
        ]
      )
    end

    def data_for_show
      @team_memberships = @team.team_memberships
    end
end
