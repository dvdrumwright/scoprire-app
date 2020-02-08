class Ride < ActiveRecord::Base
attr_accessor :title, :location, :description, :ride_distance, :ride_date, :user_id, :ride_id, :created_at, :updated_at
belongs_to :cyclist


 def slug
    self.name.downcase.split(" ").join("-")
 end

 def self.find_by_slug(slug)
    Ride.all.detect {|x| slug == x.slug}
  end
end
