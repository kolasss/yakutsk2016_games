class Api::V1::DisciplinesTeamsController < ApplicationController

  def index
    @discipline = Discipline.find(params[:discipline_id])
    @teams = @discipline.teams
    render
  end
end
