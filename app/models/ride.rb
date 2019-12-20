class Ride < ActiveRecord::Base
  belongs_to :cyclist
  has_many :rides
  has_many :post

   validates :ride_date, :location, :description, :ride_distance, presence: true
end
