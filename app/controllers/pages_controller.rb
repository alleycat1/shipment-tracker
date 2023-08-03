class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :success]

  def home
    @projects = Project.all
  end

  def success
  end

  def donations
    @shipments = current_user.donations.includes(shipment: :scans).order(shipment_id: :desc).map(&:shipment).uniq
    scans = @shipments.select { |shipment| shipment.scans.size.positive? }.map { |shipment| shipment.scans.first }
    @markers = scans.map do |scan|
      {
        lat: scan.latitude,
        lng: scan.longitude
      }
    end
    @donations = current_user.donations
  end
end
