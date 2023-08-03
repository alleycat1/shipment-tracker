class Pallet < ApplicationRecord
  CATEGORIES = ["Food", "Medicine", "Hygiene", "Clothes"]

  belongs_to :donor, class_name: "User", foreign_key: "user_id"
  belongs_to :shipment
  has_many :pallet_scans, dependent: :destroy

  validates :content, presence: true

  enum qr_code_type: [:regular, :authentic_network]
end
