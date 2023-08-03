class Project < ApplicationRecord
  has_many :shipments

  validates :name, presence: true
end
