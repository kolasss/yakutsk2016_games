class Api::V1::CountriesSportsController < ApplicationController

  def show
    @country = Country.find(params[:country_id])
    @sport = Sport.find(params[:id])

    @published_contests = @country
        .contests.published.includes(:participations)
        .joins(:discipline).merge(@sport.disciplines)

    @disciplines = @sport.disciplines

    @athletes = @country.athletes
        .joins(:disciplines).merge(@sport.disciplines)
  end
end
