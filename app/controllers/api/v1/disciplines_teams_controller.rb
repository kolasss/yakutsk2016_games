class Api::V1::DisciplinesTeamsController < Api::ApiController

  def index
    @discipline = Discipline.find(params[:discipline_id])
    @teams = @discipline.teams
  end
end
