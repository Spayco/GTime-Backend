class MeasurementsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    user = User.find(params[:id])
    render json: user.measurements
  end

  def show
    measurement = Measurement.find(params[:id])
    render json: { measurement: measurement, game: measurement.game }
  end

  def create
    user = User.find(params[:id])
    measurement = user.measurements.new(measurements_params)
    if measurement.save
      render json: measurement
    else
      render json: measurement.errors, status: :unprocessable_entity
    end
  end

  private

  def measurements_params
    params.require(:measurement).permit(:hours, :game_id)
  end
end
