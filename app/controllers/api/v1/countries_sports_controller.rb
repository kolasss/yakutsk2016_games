class Api::V1::CountriesSportsController < Api::ApiController

  def show
    @country = Country.find(params[:country_id])
    @sport = Sport.find(params[:id])
  end
end
