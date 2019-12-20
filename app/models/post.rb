class Post < ActiveRecord::Base
  belongs_to :cyclist
  has_one :ride, Through: :cyclist

  validates :ride_distance, :ride_date, :location, :artist_id, presence: true



end
