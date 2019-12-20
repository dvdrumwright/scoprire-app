class Ride < ActiveRecord::Base
  belongs_to :cyclist
  has_one :post, through: :cyclist

  validates :location, :description, :ride_distance 
end
