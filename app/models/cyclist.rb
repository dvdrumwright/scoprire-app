class Cyclist < ActiveRecord::Base
  has_many :rides
  has_many :post 

  validates :name, :email, presence: true

  has_secure_password

end
