class PalletScan < ApplicationRecord
  belongs_to :pallet

  validates_inclusion_of :sticker_destroyed, in: [true, false]

  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.find { |result| result.city && result.country }
      obj.location = "#{geo.city}, #{geo.country}"
    end
  end
  after_validation :geocode, :reverse_geocode
end
