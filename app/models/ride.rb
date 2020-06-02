class Ride < ActiveRecord::Base

  extend Concerns::Slugify::ClassMethods
  include Concerns::Slugify::InstanceMethods

  belongs_to :cyclists



end
