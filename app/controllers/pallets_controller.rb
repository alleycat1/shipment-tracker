require 'rqrcode'

class PalletsController < ApplicationController
  before_action :set_shipment, only: [:new, :create]

  def new
    @pallet = Pallet.new
    authorize @pallet
  end

  def create
    if params[:count].present? && params[:count].to_i.positive?
      params[:count].to_i.times do
        @pallet = Pallet.new(pallet_params)
        authorize @pallet
        @pallet.shipment = @shipment
        @pallet.is_complete = false # set is_complete to false by default
        unless @pallet.save
          render :new
          return
        end
      end
      redirect_to shipment_path(@shipment)
    else
      @pallet = Pallet.new(pallet_params)
      authorize @pallet
      @pallet.shipment = @shipment
      @pallet.is_complete = false # set is_complete to false by default
      if @pallet.save
        redirect_to shipment_path(@shipment)
      else
        render :new
      end
    end
  end

  def edit
    @pallet = Pallet.find(params[:id])
    authorize @pallet
  end

  def update
    @pallet = Pallet.find(params[:id])
    authorize @pallet
    @pallet.update(pallet_params)
    if @pallet.save
      redirect_to shipment_path(@pallet.shipment), notice: 'Your item was successfully updated.'
    else
      render :edit, notice: 'Error, your item was not properly edited, try again.'
    end
  end

  def destroy
    @pallet = Pallet.find(params[:id])
    authorize @pallet
    @pallet.destroy
    redirect_to shipment_path(@pallet.shipment)
  end

  def qr
    @pallet = Pallet.find(params[:pallet_id])
    authorize @pallet
    send_data RQRCode::QRCode.new(new_pallet_pallet_scan_url(@pallet)).as_png(size: 800), type: 'image/png', disposition: 'attachment'
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:shipment_id])
  end

  def pallet_params
    params.require(:pallet).permit(:user_id, :content, :content_category, :qr_code_type, :is_complete)
  end
end
