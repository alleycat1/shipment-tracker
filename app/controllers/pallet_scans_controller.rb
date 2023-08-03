class PalletScansController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]

  def new
    @pallet_scan = PalletScan.new
    @pallet = Pallet.find(params[:pallet_id])
    authorize @pallet_scan
  end

  def create
    @pallet_scan = PalletScan.new(pallet_scan_params)
    @pallet = Pallet.find(params[:pallet_id])
    @pallet_scan.pallet = @pallet
    @pallet_scan.date = DateTime.now
    authorize @pallet_scan
    if @pallet_scan.save
      respond_to do |format|
        format.html { redirect_to pallet_path(@pallet) }
        format.json { render json: @pallet_scan }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @pallet_scan.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def pallet_scan_params
    params.require(:pallet_scan).permit(:sticker_destroyed, :latitude, :longitude)
  end
end
