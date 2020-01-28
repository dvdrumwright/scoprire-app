class Ride < ActiveRecord::Base
  belongs_to :cyclist


 def slug
    self.name.downcase.split(" ").join("-")
 end

 def self.find_by_slug(slug)
    Ride.all.detect {|x| slug == x.slug}
  end
end
