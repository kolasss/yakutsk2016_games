class Api::V1::BulletinsController < ApplicationController
  before_action :set_bulletin, only: [:show, :update, :destroy]

  def index
    @bulletins = Bulletin.by_date
    render
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)

    if @bulletin.save
      render :show, status: :created
    else
      render json: {errors: @bulletin.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @bulletin.update(bulletin_params)
      render :show, status: :ok
    else
      render json: {errors: @bulletin.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @bulletin.destroy
      head :no_content
    else
      render json: {errors: @bulletin.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(
        {title: AVAILABLE_LOCALES},
        :file,
        :date
      )
    end
end
