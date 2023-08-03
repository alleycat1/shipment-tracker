class ScansController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]

  def new
    @scan = Scan.new
    @shipment = find_shipment
    authorize @scan
  end

  def create

    @scan = Scan.new(scan_params)
    @shipment = find_shipment
    @scan.shipment = @shipment
    @scan.date = DateTime.now
    authorize @scan
    if @scan.save
      respond_to do |format|
        format.html { redirect_to shipment_path(@shipment) }
        format.json { render json: @scan }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def scan_params
    params.require(:scan).permit(:sticker_destroyed, :latitude, :longitude)
  end

  def find_shipment
    Shipment.find_by(exid: params[:shipment_id])
  end
end
