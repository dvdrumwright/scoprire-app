class Cyclist < ActiveRecord::Base
  has_many :rides
  has_many :post 
end
